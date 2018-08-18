module Xmt
  module Faq
    class Mailbox
      include ModelBase
      include Mongoid::Tree
      field :title, type: String
      field :name, type: String
      field :tel, type: String
      field :email, type: String
      field :cardid, type: String
      field :address, type: String
      field :cont, type: String
      field :published_at, type: Date, default: Time.now
      field :reply, type: String
      field :ispub, type: String, default: false
      field :isshow, type: String, default: false
      field :replytime, type: Date
      field :checked, type: String, default: false
      field :replyname, type: String
      belongs_to :site, class_name: 'Xmt::Press::Site', foreign_key: :site_id, required: false

      def date(fmt = '%Y-%m-%d')
        published_at && published_at.strftime(fmt)
      end


    end
  end
end