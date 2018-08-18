module Xmt
  module Stat
    class SiteHit
      include Mongoid::Document

      field :year
      field :month
      field :day
      field :hits
      #{hour:1, hits:0}
      field :hours, type: Hash

      belongs_to :site, class_name: 'Xmt::Press::Site'

    end
  end
end
