module Xmt
  module Staff
    class Ticket
      include ModelBase
      field :user_openid, type: String
      field :create_time, type: String

      belongs_to :site, class_name: 'Xmt::Press::Site', foreign_key: :site_id, required: false
    end
  end
end
