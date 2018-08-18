module Xmt
  module Press
    class Channel < Page
      field :navigable, type: Boolean, default: true
      field :layout, type: String

      has_many :articles, class_name: 'Xmt::Press::Article', foreign_key: :parent_id, inverse_of: :channel, validate: false, autosave: true, dependent: :restrict
      has_many :channels, class_name: 'Xmt::Press::Channel', foreign_key: :parent_id, inverse_of: :parent, validate: false, autosave: true, dependent: :restrict
      has_and_belongs_to_many :relationchannels, class_name: 'Xmt::Press::Channel',  inverse_of: nil, validate: false
      has_many :permissions, as: :acopermitable, class_name: 'Xmt::Rbac::Permission', dependent: :delete
      has_many :gestbooks, class_name: 'Xmt::Press::Gestbook', foreign_key: :parent_id, inverse_of: :channel, validate: false, autosave: true, dependent: :restrict


      default_scope ->{order(seq: :asc)}
      scope :navigable, -> {where(navigable: true)}

      def channel_traversal(&block)
        result = [block.call(self)] + self.channels.collect { |c| c.send(:channel_traversal, &block) }
        result.flatten
      end
    end

  end
end
