class Resource
  include ModelBase
  include Mongoid::Tree

  has_many :privileges
  belongs_to :resourceable, polymorphic: true

end