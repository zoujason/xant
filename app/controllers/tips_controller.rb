class TipsController <  PagesController

  def new
    @message = Xmt::Faq::Tip.new
    render layout:  @page.cont_layout, template: @page.cont_tpl
  end

  def check
    render layout:  @page.cont_layout, template: @page.cont_tpl
  end

  # POST /advices
  # POST /advices.json
  def create

    @message = Xmt::Faq::Tip.new(params.require(:xmt_faq_tip).permit!)
    if verify_rucaptcha?(nil)
    respond_to do |format|
        if @message.save
          format.html { redirect_to check_tips_url(id:"5a6146bbf6e9fa1940998c00"), notice: '提交成功' }
          format.json { render :show, status: :created, location: @advice }
        else
          format.html { render :new }
          format.json { render json: @advice.errors, status: :unprocessable_entity }
        end
       end
      else
        redirect_to new_tip_url(id:"5a6146baf6e9fa1940998bff"), notice: '验证码错误'
      end


  end

end