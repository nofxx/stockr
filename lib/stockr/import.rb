require "net/http"
# require "net/http"
require "uri"

module Stockr

  class Import

    class << self

      def import(l)
        puts "Importing #{l}" #if Debug
        _, qty, name, price = l.match(/^\s*([0-9]*)x\s*([^\.\s]*)\s*\.*\s*(\d*\.?\d*)/).to_a
        return unless qty || name
        Part.find_or_create(qty, name, price)
      end

      def from_file(file)
        File.open(file).each_line { |l| import(l) }
        "Loaded"
      end

      def from_web(user = nil)
        user, pass = Stockr.get_user unless user
        puts "Downloading dump file...#{TECHUB}/#{user}.txt"
        puts url = URI.parse("#{TECHUB}/#{user}.txt")
        Net::HTTP.start(url.host, url.port) { |http|
          req = Net::HTTP::Get.new("/#{user}.txt")
          req.basic_auth user, pass if pass
          res = http.request(req)
          puts "File downloaded, parsing..."
          res.body.each_line { |l| import(l) }
        }
        puts "Done"
        # puts res.body


      end
    end

  end

end
