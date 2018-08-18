class Api::V1::CommentsController < Api::V1::BaseController

  def index
    opts = {page_id: params[:article_id]}.delete_if {|key, value| value.blank? }
    @comments = Comment.where(opts).page(params[:page])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    opts = {
        site_id: params[:site_id],
        page_id: params[:article_id],
        cont: params[:cont]
    }.delete_if {|k,v| v.blank?}
    @comment.new(opts)

    if @comment.save
      render :json => {status: :ok, notice: 'Comment was successfully created'}
    else
      render :json => {status: :sorry, notice: 'unprocessable', errors: @comment.errors}
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render json: {status: :ok, notice: 'no content'}
  end

  def add_reply
    opts = {
        parent_id: params[:parent_id],
        cont: params[:cont]
    }
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.create(opts)
    if @reply.valid?
      render :json => {status: :ok, notice: 'Reply was successfully created'}
    else
      render :json => {status: :sorry, notice: 'unprocessable', errors: @reply.errors}
    end
  end

  def del_reply
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.find_reply(params[:reply_id])
    @reply.destroy
    render json: {status: :ok, notice: 'no content'}
  end

end
