module Xmt
  module Stat
    class PageViewsController < AdminController
      before_action :set_site

      # GET /xmt/stat/page_views
      # GET /xmt/stat/page_views.json

      def show
      end

      def page_by_year
        site_id = params[:site_id] ||= @site.id
        year = params[:year] ||= Xmt::Stat::PageView.get_now_year
        page_years = Xmt::Stat::PageView.site_single_per_month(BSON::ObjectId(site_id), year.to_i)
        @year = year
        @page_year = Xmt::Stat::PageView.paginate_array(page_years,params[:page],'months')
      end

      def page_by_month
        site_id = params[:site_id] ||= @site.id
        year = params[:year] ||= Xmt::Stat::PageView.get_now_year
        month = params[:month] ||= Xmt::Stat::PageView.get_now_month
        page_months = Xmt::Stat::PageView.site_single_per_day(BSON::ObjectId(site_id), year.to_i,month.to_i)
        @year = year
        @month = month
        @page_month = Xmt::Stat::PageView.paginate_array(page_months,params[:page],'days')
      end

      def channel_by_year
        site_id = params[:site_id] ||= @site.id
        year = params[:year] ||= Xmt::Stat::PageView.get_now_year
        if params[:channel_id].blank?
          channel_stat_years = Xmt::Stat::PageView.page_per_month(BSON::ObjectId(site_id),year.to_i)
        else
          channel_stat_years = Xmt::Stat::PageView.page_per_month(BSON::ObjectId(params[:channel_id]),year.to_i)
        end
        @year = year
        @channel_site_id = site_id
        @channel_year = Xmt::Stat::PageView.paginate_array_channel(channel_stat_years,params[:page],'months')
      end

      def channel_by_month
        site_id = params[:site_id] ||= @site.id
        year = params[:year] ||= Xmt::Stat::PageView.get_now_year
        month = params[:month] ||= Xmt::Stat::PageView.get_now_month
        if params[:channel_id].blank?
          channel_stat_months = Xmt::Stat::PageView.page_per_day(BSON::ObjectId(site_id),year.to_i,month.to_i)
        else
          channel_stat_months = Xmt::Stat::PageView.page_per_day(BSON::ObjectId(params[:channel_id]),year.to_i,month.to_i)
        end
        @year = year
        @month = month
        @channel_site_id = site_id
        @channel_month = Xmt::Stat::PageView.paginate_array_channel(channel_stat_months,params[:page],'days')
      end

      def article_by_year
        site_id = params[:site_id] ||= @site.id
        year = params[:year] ||= Xmt::Stat::PageView.get_now_year
        if params[:article_id].blank?
          article_stat_years = Xmt::Stat::PageView.site_per_month(BSON::ObjectId(site_id),year.to_i)
        else
          article_stat_years = Xmt::Stat::PageView.site_per_month(BSON::ObjectId(params[:article_id]),year.to_i)
        end
        @year = year
        @article_site_id = site_id
        @article_year = Xmt::Stat::PageView.paginate_array_article(article_stat_years,params[:page],'months')
      end

      def article_by_month
        site_id = params[:site_id] ||= @site.id
        year = params[:year] ||= Xmt::Stat::PageView.get_now_year
        month = params[:month] ||= Xmt::Stat::PageView.get_now_month
        if params[:article_id].blank?
          article_stat_months = Xmt::Stat::PageView.site_per_day(BSON::ObjectId(site_id),year.to_i,month.to_i)
        else
          article_stat_months = Xmt::Stat::PageView.site_per_day(BSON::ObjectId(params[:article_id]),year.to_i,month.to_i)
        end
        @year = year
        @month = month
        @article_site_id = site_id
        @article_month = Xmt::Stat::PageView.paginate_array_article(article_stat_months,params[:page],'days')
      end

      def destroy
        stat_destroy(params[:title],params[:path])
      end

      def stat_destroy(params_title,path)
        @page_info = Xmt::Stat::PageView.where(title:params_title)
        @page_info.each do |info|
          info.destroy
        end
        respond_to do |format|
          format.html {redirect_to path, notice: '统计数据删除成功.'}
          format.json {head :no_content}
        end
      end

      def get_child_channel
        channels = Xmt::Press::Channel.where(parent_ids:BSON::ObjectId(params[:page_parent_ids]))
        render :json=>channels.map {|channel| [channel.id,channel.title]}
      end

      def get_child_article
        articles = Xmt::Press::Article.where(parent_id:params[:channel_sel])
        render :json=>articles.map {|article| [article.id,article.title]}
      end

      private
        def set_site
          @sites = Xmt::Press::Site.all
          @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
        end
    end
  end
end
