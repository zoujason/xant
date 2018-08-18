module Xmt
  module Sms
    class Notification
      include ModelBase

      field :title, type: String
      field :cont, type: String
      field :status

      belongs_to :site, class_name: 'Xmt::Press::Site'
    end
  end
end
