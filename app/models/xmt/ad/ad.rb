module Xmt
  module Ad
    class Ad
      include ModelBase
      field :title
      field :code
      field :position
      field :link
      field :effect
      field :isdelete, type: Boolean, default: false
      mount_uploader :avatar, SuploadUploader

      belongs_to :site, class_name: 'Xmt::Press::Site'


      def avatar_url(default = nil)
        avatar.url || default
      end


    end
  end
end