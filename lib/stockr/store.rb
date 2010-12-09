
module Stockr


  class Store

    class << self
      def connect!
        @db = Redis.new
        true
      end

      def db
        @@db ||= Redis.new
      end

      def find(txt)
        res = db.keys(txt)
        return nil if res.empty?
        res.reduce({}) { |h, r| h.merge(r => db.hgetall(r)) }
      end

      def write(key, value)
        db.hset(key, :qty, value)
      end

      def run(coe)
        db.send(code)
      end

      def flush
        db.flushall
      end
    end

  end



end
