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
    render layout: @page.cont_layout, template: @page.cont_tpl
  end

  def update
    unless params[:answers].blank?
      Xmt::Faq::Poll.save_answer(params[:answers])
    end
    redirect_to poll_url(id: "5a6146baf6e9fa1940998bf7", pid: params[:id]), notice: '问卷调查添加成功.'
  end

end