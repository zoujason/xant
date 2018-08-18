module Xmt
  module Stat
    class Tracker

      def self.imprint(*options)
        Xmt::Stat::PageView.create(*options)
      end

    end
  end

end
