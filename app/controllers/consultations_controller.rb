class ConsultationsController <  PagesController
  # GET /advices
  # GET /advices.json
  def index
    opts = {}
    opts[:site_id] =   @site.id
    opts[:ispub] = 'true'
    opts[:isshow] = 'true'
    @messages = Xmt::Faq::Consultation.where(opts).order(id: :desc).page(params[:page])
    render layout: @page.cont_layout, template: @page.cont_tpl
  end

  # GET /advices/1
  # GET /advices/1.json
  def show
    @message = Xmt::Faq::Consultation.find(params[:mid])
    render layout:  @page.cont_layout, template: @page.cont_tpl
  end

  # GET /advices/new
  def new
    opts = {}
    opts[:site_id] = @site.id
    opts[:ispub] = 'true'
    opts[:isshow] = 'true'
    @messages = Xmt::Faq::Consultation.where(opts).order(id: :desc).page(params[:page])
    @message = Xmt::Faq::Consultation.new
    render layout: @page.cont_layout, template: @page.cont_tpl
  end



  def list
    opts = {}
    opts[:site_id] =   @site.id
    opts[:name] = params[:name] unless params[:name].blank?
    opts[:tel] = params[:tel] unless params[:tel].blank?
    @messages = Xmt::Faq::Consultation.where(opts).order(id: :desc)
    render layout: @page.cont_layout, template: @page.cont_tpl
  end

  def check
    render layout: @page.cont_layout, template: @page.cont_tpl
  end

  # POST /advices
  # POST /advices.json
  def create
    @message = Xmt::Faq::Consultation.new(params.require(:xmt_faq_consultation).permit!)
    respond_to do |format|
      if @message.save
        format.html { redirect_to check_consultations_url(id:"5a6146baf6e9fa1940998bf3"), notice: '提交成功' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

end