module Xmt
  module Press
    class Comment
      include ModelBase

      field :title
      field :cont
      field :author
      field :checked, type: Boolean, default: true
      field :rcmded
      field :ip

      default_scope -> {where(checked: true)}

      belongs_to :page, class_name: 'Xmt::Press::Page', required: false
      belongs_to :site, class_name: 'Xmt::Press::Site', required: false
      embeds_many :replies, class_name: 'Reply'

      def find_reply(id)
        self.replies.detect {|reply| reply.id.to_s == id.to_s}
      end

      def child_reply(parent_id)
        self.replies.select {|reply| reply.parent_id.to_s == parent_id.to_s}
      end

      def each_reply(parent_id, &block)
        child_reply(parent_id).each do |reply|
          block.call(reply)
          if child_reply(reply.id).size > 0
            each_reply(reply.id, &block)
          end
        end
      end


      set_callback :create, :before do |doc|
        doc.author = doc.created_by.try(:username)
      end


    end
  end
end
