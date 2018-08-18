class SharedocsController < PagesController
  # GET /sharedocs/1
  # GET /sharedocs/1.json
  def show
    @sharedoc = Xmt::Faq::Sharedoc.find(params[:sid])
    render layout: @page.cont_layout, template:  @page.cont_tpl
  end

  # GET /sharedocs/new
  def new
    @sharedoc = Xmt::Faq::Sharedoc.new
    render layout: @page.cont_layout, template:  @page.cont_tpl
  end

  def list
    opts = {}
    opts[:site_id] =   @site.id
    opts[:pwd] = params[:pwd] unless params[:pwd].blank?
    opts[:tel] = params[:tel] unless params[:tel].blank?
    @sharedocs = Xmt::Faq::Sharedoc.where(opts).order(id: :desc)
    render layout: @page.cont_layout, template:  @page.cont_tpl
  end


  def check
    render layout: @page.cont_layout, template:  @page.cont_tpl
  end

  # POST /sharedocs
  # POST /sharedocs.json
  def create
    @sharedoc = Xmt::Faq::Sharedoc.new(params.require(:xmt_faq_sharedoc).permit!)
    respond_to do |format|
      if @sharedoc.save
        format.html { redirect_to check_sharedocs_url(id:"5a6146baf6e9fa1940998bf0"), notice: '提交成功' }
        format.json { render :show, status: :created, location: @sharedoc }
      else
        format.html { render :new }
        format.json { render json: @sharedoc.errors, status: :unprocessable_entity }
      end
    end
  end

end
