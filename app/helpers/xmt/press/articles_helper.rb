module Xmt::Press::ArticlesHelper

  def option_status
    dicts = [:draft]
    add = [:pending, :hidden]
    edit = [:pending, :hidden, :reviewed, :published]

    if subject.allow(@channel.id, :edit)
      dicts = dicts +  edit
    elsif subject.allow(@channel.id, :add)
      dicts = dicts +  add
     end
    Xmt::Core::Dict.where(typ: :article_status).in(sign: dicts)
  end

end
