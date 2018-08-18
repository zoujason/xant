module Xmt
  module Press
    class Article < Page

      has_and_belongs_to_many :relationships, class_name: 'Xmt::Press::Article',  inverse_of: nil, validate: false
      belongs_to :dept, class_name: 'Xmt::Staff::Dept',required:false
      belongs_to :channel, class_name: 'Xmt::Press::Channel', foreign_key: :parent_id, inverse_of: :articles, dependent: :nullify
      has_and_belongs_to_many :relationchannels, class_name: 'Xmt::Press::Channel',  inverse_of: nil, validate: false

      set_callback :create, :before do |doc|
        doc.author ||= doc.created_by.try(:username)
      end

      set_callback :create, :before do |doc|
        doc.seo_title = doc.title
        doc.seo_description = doc.desc
      end

    end

  end
end

