class CommentsController < PagesController

  def index
    @comments = Xmt::Press::Comment.page(params[:page]).per(10)
  end

  def post
    opts = {
        title: params[:title],
        cont: params[:cont],
        site_id: params[:site_id],
        page_id: params[:page_id]
    }.delete_if {|k,v| v.blank?}
    @comment = Xmt::Press::Comment.new(opts)
    if verify_rucaptcha?(nil)
      if @comment.save
        redirect_to "/pages/#{params[:page_id]}", notice: '民意征集内容提交成功!'
      else
        redirect_to "/pages/#{params[:page_id]}", notice: '民意征集内容提交失败!'
      end
    else
      redirect_to "/pages/#{params[:page_id]}", notice: '验证码错误!'
    end


  end


  def reply
    @comment = Xmt::Press::Comment.find_by(id: params[:comment_id])
    reply = @comment.replies.create(cont: params[:cont],parent_id: params[:parent_id])
    params[:answer] ||= ''
    if reply.valid?
      redirect_to "/pages/#{params[:page_id]}?answer=#{params[:answer]}", notice: '回复成功!'
    else
      redirect_to "/pages/#{params[:page_id]}?answer=#{params[:answer]}", notice: '回复失败!'
    end
  end

  def destroy
    @comment = Xmt::Press::Comment.find_by(id: params[:comment_id])
    if @comment && @comment.created_by_id == subject.user.id
      @comment.destroy
      redirect_to "/pages/#{params[:page_id]}", notice: '评论删除成功!'
    else
      redirect_to "/pages/#{params[:page_id]}", notice: '评论删除失败!'
    end
  end


end
