class Reply
  include ModelBase

  field :cont
  field :author
  field :parent_id
  field :checked, type: Boolean, default: true

  embedded_in :comment

  default_scope ->{where(checked: true)}

  set_callback :create, :before do |doc|
    doc.author = doc.created_by.try(:username)
  end

end