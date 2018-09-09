class PollsController < PagesController

  def index
    opts = {}
    opts[:site_id] = @site.id
    @polls = Xmt::Faq::Poll.where(opts).order(id: :desc).page(params[:page])
    render layout: @page.cont_layout, template: @page.cont_tpl
  end

  # GET /advices/1
  # GET /advices/1.json
  def show
    @poll = params[:pid].blank? ? Xmt::Faq::Poll.first : Xmt::Faq::Poll.find(params[:pid])
    cont_layout =  @page.cont_layout
    cont_tpl = @page.cont_tpl
    if @page.site.mobile? && mobile?
      cont_tpl, cont_layout = "m_#{cont_tpl}" , "m_#{cont_layout}"
    end
    render layout: cont_layout, template: cont_tpl
  end

  def update
    unless params[:answers].blank?
      Xmt::Faq::Poll.save_answer(params[:answers])
    end
    # redirect_to poll_url(id: "5b94b319d9737f1bcc7c96a1", pid: params[:id]), notice: '问卷调查添加成功.'
    redirect_to poll_url(id: "5b94c02920ed4e0505b7793c", pid: params[:id]), notice: '问卷调查添加成功.'
  end

end