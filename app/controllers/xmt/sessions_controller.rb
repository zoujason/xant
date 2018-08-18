module Xmt
  class SessionsController < AdminController
    #before_action :set_mgr_session, only: [:show, :edit, :update, :destroy]
    skip_before_action :authc_filter
    layout 'login'

    # GET /xmt/sessions
    # GET /xmt/sessions.json
    def index
      subject.logout
    end

    # GET /xmt/sessions/1
    # GET /xmt/sessions/1.json
    def show
    end

    # GET /xmt/sessions/new
    def new

    end

    # GET /xmt/sessions/1/edit
    def edit
    end

    # POST /xmt/sessions
    # POST /xmt/sessions.json
    def create
      token = Waas::FormToken.new(params[:username], params[:password], !params[:remember].blank?)
      #if verify_rucaptcha?(nil) && subject.login(token)
      if subject.login(token)
        if token.is_remember_me
          cookies.permanent[:auth_token] = subject.remember_token
        else
          cookies.delete :auth_token
        end
        redirect_to Waas.home_url
      else
        render 'new'
      end
    end

    # PATCH/PUT /xmt/sessions/1
    # PATCH/PUT /xmt/sessions/1.json
    def update
      respond_to do |format|
        if @mgr_session.update(session_params)
          format.html {redirect_to @mgr_session, notice: '修改成功.'}
          format.json {render :show, status: :ok, location: @mgr_session}
        else
          format.html {render :edit}
          format.json {render json: @mgr_session.errors, status: :unprocessable_entity}
        end
      end
    end

    # DELETE /xmt/sessions/1
    # DELETE /xmt/sessions/1.json
    def destroy
      subject.logout
      session[:subject] = false
      respond_to do |format|
        format.html {redirect_to '/xmt/sessions/new', notice: ''}
        format.json {head :no_content}
      end
    end


    def clear_dates
      Xmt::Press::Page.update_all(caching_data:'',caching_enabled:false)
      redirect_to xmt_press_articles_url
    end


    private

    # Use callbacks to share common setup or constraints between actions.
    def set_mgr_session
      @mgr_session = Xmt::Session.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.require(:sessions).permit!

    end
  end
end
