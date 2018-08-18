json.member do
  json.extract! member, :id, :username, :title, :gender, :tel, :email, :hobbies, :about
  json.avatar (member.avatar.try(:url))

end
