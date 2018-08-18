module ModelBase
  extend ActiveSupport::Concern

  included do
    include Mongoid::Document
    include Mongoid::Timestamps

    field :actived, type: Boolean, default: true
    field :datatype, type: Symbol, default: :app #:sys, :app
    field :seq, type: Integer, default: 0
    field :desc

    belongs_to :created_by, class_name: 'Xmt::Staff::User', foreign_key: :created_by_id, required: false
    belongs_to :updated_by, class_name: 'Xmt::Staff::User', foreign_key: :updated_by_id, required: false

    set_callback :create, :before do |doc|
      doc.created_by_id = Waas::Security.subject.try(:user_id)
      doc.updated_by_id = Waas::Security.subject.try(:user_id)
    end

    set_callback(:update, :before) do |doc|
      doc.updated_by_id = Waas::Security.subject.try(:user_id)
    end

    set_callback(:destroy, :before) do |doc|
        if self.datatype.to_sym == :sys && Waas::Security.subject && !Waas::Security.subject.has_role(:sys_admin)
          errors[:base] <<  '此为系统数据，只有超级管理员能操作！'
          false
        end
    end

    set_callback(:update, :before) do |doc|
      if self.datatype.to_sym == :sys && Waas::Security.subject && !Waas::Security.subject.has_role(:sys_admin)
        errors[:base] <<  '此为系统数据，只有超级管理员能操作！'
        false
      end
    end

  end
end