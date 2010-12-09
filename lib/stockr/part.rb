

module Stockr

  class Part
    attr_reader :name, :qty, :price

    def initialize(name, qty = 0, pr = 0)
      @name = name.upcase
      @qty = qty.to_i
      self.price = pr
    end

    def save
      Store.write(name, { :qty => qty, :price => price })
    end

    def facts
      out = "#{qty}x #{name}"
      if price && !price.zero?
        out << ("." * (50 - out.size))
        out << "$ %.3f" % price
        out << " ($ %.3f)" % (price * qty) if qty != 1
      end
      out
    end

    def qty=(v)
      @qty = v
    end

    def price=(pr)
      @price = pr.kind_of?(Numeric) ? pr : pr.gsub(",", ".").to_f
    end

    def self.create_or_increment(q, name, pr=0)
      part = search(name, true) || new(name)
      part.qty += q.to_i
      part.price = pr
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

    def self.all;      search('');    end

    def self.list(txt = "*")
      search(txt).map(&:facts) rescue []
    end


  end


end
