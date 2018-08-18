module Xmt
  module Press
    class ArticlesController < AdminController
      before_action :set_article, only: [:show, :edit, :update, :to_recycle]
      before_action :set_site_and_channel


      # GET /xmt/articles
      # GET /xmt/articles.json
      def index
        @sites = Xmt::Press::Site.all.to_a
        opts = {
            parent_ids: @site.id,
            status: params[:status],
            headline_level: params[:head],
            rcmd_level: params[:rcmd]
        }.delete_if {|k, v| v.blank?}
        unless params[:channel_id].to_s == @site.id.to_s
          opts[:parent_id] = params[:channel_id] unless params[:channel_id].blank?
        end
        opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?
        opts[:dept_id] = subject.user.dept_id unless subject.has_role(:sys_admin) || subject.has_role(:admin)
        @articles = Xmt::Press::Article.includes(:channel).where(opts).order(id: :desc).page(params[:page])
      end

      # GET /xmt/articles/1
      # GET /xmt/articles/1.json
      def show
        @sites = Xmt::Press::Site.all.to_a
      end

      # GET /xmt/articles/new
      def new
        @article = Xmt::Press::Article.new(published_at: Time.now)
      end

      # GET /xmt/articles/1/edit
      def edit

      end

      # POST /xmt/articles
      # POST /xmt/articles.json
      def create
        pictures = article_params.delete(:pictures)
        unless article_params[:attr].blank?
          article_params[:attr] =  Xmt::Form::Filter.filte(article_params[:attr],params[:page_type])
        end
        @article = Xmt::Press::Article.new(article_params)
        @article.cont =  @article.sensitive(@sensitives,article_params[:cont])

        respond_to do |format|
          if @article.save
            unless pictures.blank?
              @article.pictures = []
              pictures.each do |f|
                @article.pictures.create(pic: f)
              end
            end

            unless(@article.relationchannels.blank?)
              create_same_articles(@article)
            end



            format.html { redirect_to xmt_press_articles_url(channel_id: article_params[:parent_id]), notice: '文章创建成功.' }
            format.json { render :show, status: :created, location: article }
          else
            format.html { render :new }
            format.json { render json: @article.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /xmt/articles/1
      # PATCH/PUT /xmt/articles/1.json
      def update
        pictures = article_params.delete(:pictures)
        change = relationchannels_changed?(@article,article_params[:relationchannel_ids])
        if change
          delete_same_articles(@article);
        end

        unless article_params[:attr].blank?
          article_params[:attr] =  Xmt::Form::Filter.filte(article_params[:attr],params[:page_type])
        end


        article_params[:cont] =  @article.sensitive(@sensitives,article_params[:cont])
        respond_to do |format|
          if @article.update(article_params)
            unless pictures.blank?
              @article.pictures = []
              pictures.each do |f|
                @article.pictures.create(pic: f)
              end
            end

            if change && !@article.relationchannels.blank?
              create_same_articles(@article)
            end

            #@article.filter(params[:rdf_type])

            # @article.filter(params[:rdf_type])


            format.html { redirect_to xmt_press_articles_url(channel_id: article_params[:parent_id]), notice: '文章更新成功.' }
            format.json { render :show, status: :ok, location: @article }
          else
            format.html { render :edit }
            format.json { render json: @article.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /xmt/articles/1
      # DELETE /xmt/articles/1.json
      def destroy
        article=Article.where({actived:false,id:params[:id]}).first
        unless article.relationchannels.blank?
          delete_relationchannel(article)
        end
        article.destroy
        respond_to do |format|
          format.html { redirect_to recycle_xmt_press_articles_url(site_id: @site.id, channel_id: @channel.id), notice: '文章删除成功.' }
          format.json { head :no_content }
        end
      end

      def lookup

        @articles = Article.in(parent_id:@channel.relationchannel_ids).page(params[:page])
        p @channel.id
        unless params[:key].blank?
          key = /.*#{params[:key]}.*/
          @articles = @articles.where(title: key).page(params[:page])
        end
        render layout: "lookup", template: "xmt/press/articles/lookup"
      end

      def to_recycle
        # render plain:@article.inspect and return
        if @article.update(actived: false)
          redirect_to xmt_press_articles_url(site_id: @site.id, channel_id: params[:channel_id]), notice: '文章删除成功.'
        end
      end

      def recycle
        opts = {actived: false}
        opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?
        @sites = Xmt::Press::Site.all.to_a
        @articles = Xmt::Press::Article.includes(:channel).where(opts).order(id: :desc).page(params[:page])
      end

      def recovery
        article = Xmt::Press::Article.where(id: params[:id],actived:false).first
        if article.update(actived: true)
          redirect_to recycle_xmt_press_articles_path(site_id: @site.id, channel_id: @channel.id), notice: '文章还原成功.'
        end
      end

      def recycle_by_site
        @sites = Xmt::Press::Site.all.to_a
        @articles = Xmt::Press::Article.includes(:channel).where(parent_ids: BSON::ObjectId(params[:site_id]), actived: false).order(id: :desc).page(params[:page])
      end

      def destroy_batch
        ids = params[:ids]
        if Xmt::Press::Article.where(actived: false,:id.in=>ids).destroy_all()>0
          render plain:200
        else
          render plain:401
        end
      end
#     文章复制相关 start
      def copy_to(article,channel)
        fields = ["_id","parent_id","parent_ids"]
        new_article = article.clone_to_hash.delete_if{|key,v| fields.include?(key)}
        new_article = Xmt::Press::Article.new(new_article)
        new_article.parent_id = channel.id.to_s
        new_article.relationchannel_ids << article.parent_id
        new_article.relationchannel_ids = new_article.relationchannel_ids - [channel.id]
        return new_article.save
      end

      def create_same_articles(article)
        article.relationchannels.each do |c|
          unless c.blank?
            copy_to(article,c)
          end
        end
      end

      def delete_same_articles(article)
        article.relationchannels.each do |c|
          unless c.blank?
            Xmt::Press::Article.where({title:article.title,parent_id:c}).delete
          end
        end
      end

      def relationchannels_changed?(article,params)
        artcile_relationchannels = article.relationchannel_ids.map{|c|c.to_s}
        return !(artcile_relationchannels == params)
      end

      def delete_relationchannel(article)
        article.relationchannels.each do |c|
          same_article = Xmt::Press::Article.where({title:article.title,parent_id:c}).first
          new_relationchannels = same_article.relationchannel_ids.delete_if{|chan| chan==article.channel.id}
          same_article.update_attribute(:relationchannel_ids,new_relationchannels)
        end
      end
#     文章复制相关 end

#     图片集图片删除
      def delete_pic
        article_id = params[:id]
        pic_id = params[:pic_id]
        article = Xmt::Press::Article.where(id:article_id).first
        pic = article.pictures.where(id:pic_id).first
        if article && pic
          pic.remove
          render plain: 400
        else
          render plain: 401
        end
      end
#     缩略图图片删除
      def delelte_avatar
        article_id = params[:id]
        article =  Xmt::Press::Page.where(id:article_id).first
        if !article.blank? && !article.avatar.blank?
          article.avatar.remove!
          render plain: 400
        else
          render plain: 401
        end
      end
#     图片集增加图片
      def add_pic
        article =  Xmt::Press::Article.where(id:params[:aid]).first
        picture = params[:pic]
        if article
          pic = article.pictures.create(pic:picture)
          render plain: pic.id
        else
          render plain: 401
        end
      end

      def cust_article
        @cust_articles = Xmt::Press::Article.all.select{|a| a.channel.page_type_id.to_s == params[:cust_model]}
        @articles = Kaminari.paginate_array(@cust_articles, total_count: @cust_articles.size).page(params[:page])
        render layout: 'admin', template: 'xmt/press/articles/index'
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_article
        @article = Xmt::Press::Article.find(params[:id])
      end

      def set_site_and_channel
        @site =  params[:site_id].blank? ? Xmt::Press::Site.first : Xmt::Press::Site.where(id: params[:site_id]).first
        @channel = params[:channel_id].blank? ? @site : Xmt::Press::Channel.where(id: params[:channel_id]).first
        @comments = params[:id].blank? ? {} : Xmt::Press::Comment.where(page_id: params[:id]).page(params[:page])
        @sensitives = Xmt::Press::Sensitive.where(enable:true)
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def article_params
        params.require(:xmt_press_article).permit!
      end

    end

  end
end
