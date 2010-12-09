

module Stockr

  class Part
    attr_reader :name, :qty, :price

    def initialize(name, qty = 0, pr = 0)
      @name = name.upcase
      @qty = qty.to_i
      self.price = pr
    end

    def save
      return false unless name && !name.empty?
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
      # BigDecimal.new()
      @price = pr.kind_of?(Numeric) ? pr.to_f : pr.gsub(",", ".").to_f
    end

    def price_total
      price * qty
    end

    def to_json
      "{name: '#{name}', qty: '#{qty}', price: '%.3f', total_price: '%.3f'}" % [price, price_total]
    end

    def self.find_or_create(q, name, pr=0, incr = false)
      part = search(name, true) || new(name)
      incr ? part.qty += q.to_i : part.qty = q.to_i
      part.price = pr
      part.save
      part
    end

    def self.create_or_increment(q, name, pr=0)
      find_or_create(q, name, pr, true)
    end

    def self.search(txt, exact = false)
      if res = Store.find(exact ? txt : "*#{txt}*")
        objs = res.map do |k, r|
          new(k, r["qty"], r["price"])
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

    def self.missing
      all.select { |p| p.qty <= 0 }
    end


  end


end
