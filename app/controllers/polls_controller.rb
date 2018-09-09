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
      p "1111"
      cont_tpl, cont_layout = "m_#{cont_tpl}" , "m_#{cont_layout}"
    end
    p "3333:#{cont_layout}"
    p "4444:#{cont_tpl}"
    render layout: cont_layout, template: cont_tpl
  end

  def update
    unless params[:answers].blank?
      Xmt::Faq::Poll.save_answer(params[:answers])
    end
    redirect_to poll_url(id: "5b852d94d9737f0d24aeb3a7", pid: params[:id]), notice: '问卷调查添加成功.'
  end

end