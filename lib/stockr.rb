require "rubygems"
require "redis"

require "stockr/store"
require "stockr/part"

module Stockr



  def self.work(txt)
    txt = txt.split(" ") unless txt.is_a? Array
    parse = txt
    if parse.size == 1
      puts "Searching...#{txt.join}"
      res = Part.search(txt.join.upcase)
      return "Not found... go shop!" unless res && !res.empty?
      res.map(&:facts).join("\n")
    else
      qty, name = parse
      if part = Part.create_or_increment(name, qty)
        return "Done. #{part.facts}"
      else
        "Problems creating part..."
      end
    end


  end


end
