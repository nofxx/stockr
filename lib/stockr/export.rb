#
#
# Export Redis DB to various formats
#
#

require 'net/http/post/multipart'

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
#
#  Stockr Export
#
#  #{Time.now.strftime("%d/%b/%Y %H:%M:%S")}
#
---------------------------------------------------------------------

#{Part.list.join("\n")}

---------------------------------------------------------------------
Total: #{all.size} Part(s).
$ #{Part.sum}

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

      def write(txt, ext, path = nil)
        fname = filename + ".#{ext}"
        fname = path + fname if path
        File.open(fname, "w") { |f| f << txt }
        fname
      end

      def to_web
        user, pass = Stockr.get_user unless user
        file = write(format, :txt, "/tmp/")
        puts "Exporting db to techub..."
        url = URI.parse(TECHUB + "/push")
        File.open(file) do |f|
          Net::HTTP.start(url.host, url.port) do |http|
            req = Net::HTTP::Post::Multipart.new url.path, "file" => UploadIO.new(f, "text/plain", file)
            req.basic_auth user, pass if pass
            puts "Sending file..."
            http.request(req)
            puts req.body
          end
          puts "Done."
        end


      end

    end

  end

end
