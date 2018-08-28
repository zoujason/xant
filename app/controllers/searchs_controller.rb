class SearchsController < PagesController

  def show

    opts = {}
      unless params[:keywords].blank?
        opts[:title] = /.*#{params[:keywords]}.*/
      end
    @search_articles = Xmt::Press::Article.seq.recently.publishings.where(opts).page(params[:page]).per(15)
    render layout: @page.cont_layout, template: @page.cont_tpl
  end


  def zwgk

    opts = {}

    unless params[:channel_id].blank?
      opts[:parent_ids] =  BSON::ObjectId(params[:channel_id])
    end

    unless params[:title].blank?
      opts[:title] = /.*#{params[:title]}.*/
    end

    unless params[:index_no].blank?
      opts[:index_no] = params[:index_no]
    end


    @search_articles = Xmt::Press::Government.seq.recently.publishings.where(opts).page(params[:page]).per(15)
    @channel = Xmt::Press::Channel.find(params[:channel_id])
    render layout: @page.cont_layout, template: 'tpl_search_zwgk'

  end



  def gkml

    opts = {}

    unless params[:channel_id].blank?
      opts[:parent_ids] =  BSON::ObjectId(params[:channel_id])
    end

    if params[:leibie]=='title'
      opts[:title] = /.*#{params[:keywords]}.*/ unless params[:keywords].blank?
    end

    if params[:leibie]=='index_no'
      opts[:index_no] = /.*#{params[:keywords]}.*/ unless params[:keywords].blank?
    end

    if params[:leibie]=='doc_no'
      opts[:doc_no] = /.*#{params[:keywords]}.*/ unless params[:keywords].blank?
    end


    @search_articles = Xmt::Press::Government.published_at.seq.recently.publishings.where(opts).page(params[:page]).per(15)

    @channel = Xmt::Press::Channel.find(params[:channel_id])
    render layout: 'theme_zeta', template: 'tpl_search_gkml'

  end




end