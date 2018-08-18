module Xmt
  module Staff
    class Member < User

      belongs_to :site, class_name: 'Xmt::Press::Site', foreign_key: :site_id, required: false
    end
  end
end
