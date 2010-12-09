#
#
# Export Redis DB to various formats
#
#
module Stockr

  class Export

    class << self

      def all
        @all ||= Part.search("") || []
      end

      def timestamp
        @ts ||= Time.now.strftime("%y-%m-%d-%H-%M-%S")
      end

      def format
        <<TXT
Stockr Export

  #{timestamp}

-------------------------------------------

#{Part.list.join("\n")}

-------------------------------------------
Total: #{all.size}

TXT
      end

      def filename
        "my_stockr_" + timestamp
      end

      def txt
        write(format, "txt")
      end

      def csv
        output = "name,qty,price\n"
        for p in all
          output << [p.name, p.qty, p.price].join(",")
        end
        output << "\n"
        write(output, "csv")
      end

      def html
      end

      def pdf
      end

      def xml
      end

      def write(txt, ext)
        fname = filename + ".#{ext}"
        File.open(fname, "w") { |f| f << txt }
        fname
      end

    end

  end

end
