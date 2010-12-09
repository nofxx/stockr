

module Stockr

  class Part
    attr_reader :qty, :name

    def initialize(name, qty = 0)
      @name = name.upcase
      @qty = qty.to_i
    end

    def save
      Store.write(@name, @qty)
    end

    def facts
      "#{qty}x #{name}"
    end

    def qty=(v)
      @qty = v
    end


    def self.create_or_increment(name, q)
      part = search(name, true) || new(name)
      part.qty += q.to_i
      part.save
      part
    end

    def self.search(txt, exact = false)
      if res = Store.find(exact ? txt : "*#{txt}*")
        objs = res.map do |k, r|
          new(k, r["qty"])
        end
        exact ? objs[0] : objs # FIXME: better way?
      else
        nil
      end
    end


  end


end
