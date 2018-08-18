module Xmt
  module Faq
    class Tip
  include ModelBase
  include Mongoid::Tree
  field :bjb_name,type:String
  field :jb_name,type:String
  field :jb_sex,type:String
  field :bjb_sex,type:String
  field :bjb_job,type:String
  field :jb_job,type:String
  field :bjb_position,type:String
  field :jb_position,type:String
  field :jb_tel,type:String
  field :jb_cord,type:String
  field :jb_cardid,type:String
  field :bjb_address,type:String
  field :jb_address,type:String
  field :bjb_jibie,type:String
  field :jb_jibie,type:String
  field :bjb_type,type:String
  field :bjb_patry,type:String
  field :cont,type:String
  field :published_at,type:Date, default: Time.now
  field :reply,type:String
  field :ispub,type:String, default: false
  field :isshow,type:String, default: false
  field :replytime,type:Date
  field :checked ,type: String, default: false
  field :replyname,type:String

  belongs_to :site, class_name: 'Xmt::Press::Site', foreign_key: :site_id , required: false

  def date(fmt = '%Y-%m-%d')
    published_at && published_at.strftime(fmt)
  end

    end
  end
end
