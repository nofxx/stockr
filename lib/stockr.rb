require "rubygems"
require "redis"
require "eletro"

require "stockr/store"
require "stockr/part"
require "stockr/import"
require "stockr/export"

module Stockr

  FORMATS = %w{ txt csv html pdf xml }
  DOTFILE = ENV['HOME'] + "/.stockr"
#  TECHUB  = "http://techub.heroku.com"
  TECHUB  = "http://localhost:3000"

  def self.print_parts(res)
    return "Not found... go shop!" unless res && !res.empty?
    res.map(&:facts).join("\n")

  end

  def self.get_user
    unless File.exists?(DOTFILE)
      puts "What\`s your techub username?"
      name = gets.chomp
      puts "Password?"
      pass = gets.chomp
      File.open(DOTFILE, "w") { |f| f << "name: #{name}\npass: #{pass}"}
    end
    @conf = YAML.load(File.read(DOTFILE))
    [@conf["name"], @conf["pass"]]
  end

  def self.run(txt)
    if txt.size == 1
      if txt.join =~ /#{FORMATS.join('|')}/
        f = Export.send(txt[0].to_sym)
        "File saved! #{f}"
      else
        puts "Searching...#{txt.join}"
        print_parts parts = Part.search(txt.join.upcase)
        parts
      end
    else
      if part = Part.create_or_increment(*txt)
        puts "Ok, #{part.facts}"
      else
        puts "Problems creating part..."
      end
      part
    end
  end

  def self.work(txt)
    get_user
    txt = txt.split(" ") unless txt.is_a? Array
    parse = txt
    case parse.join
    when "all" then puts Export.format
    when "web" then
      puts "Starting websever on port."
      require "stockr/web"
    when "shop" then print_parts(Part.missing)
    when /load.*/ then Import.from_file txt[1] #ARGF
    when /pull.*/ then Import.from_web
    when /push.*/ then Export.to_web
    else run(txt)
    end

  end


end
