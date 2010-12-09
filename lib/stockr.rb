require "rubygems"
require "redis"

require "stockr/store"
require "stockr/part"
require "stockr/export"

module Stockr

  FORMATS = %w{ txt csv html pdf xml }

  def self.print_parts(res)
    return "Not found... go shop!" unless res && !res.empty?
    res.map(&:facts).join("\n")

  end


  def self.work(txt)
    txt = txt.split(" ") unless txt.is_a? Array
    parse = txt
    case parse.join
    when "all" then puts Export.format
    when "web" then
      puts "Starting websever on port."
      require "stockr/web"
    when "shop" then print_parts(Part.missing)
    else
      if parse.size == 1
        if parse.join =~ /#{FORMATS.join('|')}/
          f = Export.send(parse[0].to_sym)
          "File saved! #{f}"
        else
          puts "Searching...#{txt.join}"
          print_parts Part.search(txt.join.upcase)
        end
      else
        if part = Part.create_or_increment(*parse)
          return "Done. #{part.facts}"
        else
          "Problems creating part..."
        end
      end

    end

  end


end
