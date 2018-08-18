module Xmt
  module Press
    class CommentsController < AdminController
      before_action :set_comment, only: [:show, :edit, :update, :destroy]
      before_action :set_site
      before_action :set_article
      # GET /xmt/comments
      # GET /xmt/comments.json
      def index
        @site ||= @sites.first
        @comments = Xmt::Press::Comment.where(site_id: @site.id).page(params[:page])
        unless params[:key].blank?
          key = /.*#{params[:key]}.*/
          @comments = @comments.where(cont: key).page(params[:page])
        end
        #@comments =Comment.all.page(params[:page]).per(10)
      end

      # GET /xmt/comments/1
      # GET /xmt/comments/1.json
      def show
      end

      # GET /xmt/comments/new
      def new
        @comment = Xmt::Press::Comment.new
      end

      # GET /xmt/comments/1/edit
      def edit
      end

      # POST /xmt/comments
      # POST /xmt/comments.json
      def create
        @comment = Xmt::Press::Comment.new(comment_params)

        respond_to do |format|
          if @comment.save
            format.html {redirect_to xmt_press_comments_url, notice: '评论添加成功.'}
            format.json {render :show, status: :created, location: @comment}
          else
            format.html {render :new}
            format.json {render json: @comment.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/comments/1
      # PATCH/PUT /xmt/comments/1.json
      def update
        respond_to do |format|
          if @comment.update(comment_params)
            format.html {redirect_to xmt_press_comments_url, notice: '评论修改成功.'}
            format.json {render :show, status: :ok, location: @comment}
          else
            format.html {render :edit}
            format.json {render json: @comment.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/comments/1
      # DELETE /xmt/comments/1.json
      def destroy
        @comment.destroy
        respond_to do |format|
          format.html {redirect_to xmt_press_comments_url, Comment: '评论删除成功.'}
          format.json {head :no_content}
        end
      end

      def reply
        @comment = Xmt::Press::Comment.find(params[:id])
        @commnet_rply = @comment.find_reply(params[:parent_id]) unless params[:parent_id].blank?
      end

      def save_reply
        @comment = Xmt::Press::Comment.find(params[:comment_id])
        @comment.replies.create(cont: params[:cont], parent_id: params[:parent_id])
        redirect_to xmt_press_comment_path(params[:comment_id]), Comment: '回复成功.'
      end

      def del_reply
        @comment = Xmt::Press::Comment.find(params[:comment_id])
        @comment.find_reply(params[:id]).destroy
        redirect_to xmt_press_comment_path(params[:comment_id]), Comment: '删除成功.'
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Xmt::Press::Comment.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def comment_params
        params.require(:xmt_press_comment).permit!
      end

      def set_site
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
      end

      def set_article
        @articles = Xmt::Press::Article.where(parent_ids: @site.id)
        ## @article = params[:site_id].blank?@articles.find(params[:site_id])
      end

    end
  end
end

