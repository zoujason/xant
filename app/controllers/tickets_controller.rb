class TicketsController < PagesController
  before_action :get_openid

  def index

    redirect_to '/pages/5b2de4ff12c15b48726bcbce?openid='+@openid
  end

  # GET /advices/1
  # GET /advices/1.json
  # def show
  #   @article = params[:pid].blank? ? Xmt::Press::Article.first : Xmt::Press::Article.find(params[:pid])
  #   redirect_to '/pages/5b2de4ff12c15b48726bcbce?openid='+@openid
  # end

  def do_ticket
    unless params[:answers].blank?
      date = Time.now.to_s[0,10]

      if !@openid.blank?
        @ticket = Xmt::Staff::Ticket.where(user_openid:@openid.to_s,create_time:date).first
        if @ticket.blank?
          Xmt::Press::Article.save_tp(params[:answers],@openid.to_s)
          @notice = '投票成功！'
          redirect_to '/pages/5b2de4ff12c15b48726bcbce?openid='+@openid,notice:@notice
        elsif !@ticket.blank?
          created_at = @ticket.create_time
          if date.to_s != created_at.to_s
            Xmt::Press::Article.save_tp(params[:answers],@openid.to_s)
            @notice = '投票成功！'
            redirect_to '/pages/5b2de4ff12c15b48726bcbce?openid='+@openid,notice:@notice
          elsif date.to_s == created_at.to_s
            @notice = '您今日已经进行过投票！'
            redirect_to '/pages/5b2de4ff12c15b48726bcbce?openid='+@openid,notice:@notice
          end
        end
      else
        @notice = '登录过期！请重新访问！'
        redirect_to '/pages/5b2de4ff12c15b48726bcbce?openid='+@openid,notice:@notice
      end

    end
  end

  def to_ticket
    @openid = params[:openid]
    logger.debug params[:openid]
    render layout: 'm_theme', template: 'm_tpl_ticket'
  end

  private
  def get_openid
    @openid = params[:openid]
  end


end