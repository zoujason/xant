class Picture
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :pic, SuploadUploader
  embedded_in :page, inverse_of: :pictures

end