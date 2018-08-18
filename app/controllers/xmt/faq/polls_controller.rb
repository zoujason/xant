module Xmt
  module Faq
    class PollsController < AdminController
      before_action :set_poll, only: [:show, :edit, :update, :destroy]
      before_action :set_site
      # GET /polls
      # GET /polls.json
      def index
        @polls = Xmt::Faq::Poll.where(site_id: @site.id).page(params[:page])
        unless params[:key].blank?
          key = /.*#{params[:key]}.*/
          @polls = @polls.where(title: key).page(params[:page])
        end
      end

      # GET /polls/1
      # GET /polls/1.json
      def show
      end

      # GET /polls/new
      def new
        @poll = Xmt::Faq::Poll.new
      end

      # GET /polls/1/edit
      def edit
      end

      # POST /polls
      # POST /polls.json

      def create
        @poll = Xmt::Faq::Poll.create(params[:xmt_faq_poll].permit!)
        params[:questions].each do |q|
          @poll.questions.create(q.permit!)
        end

        respond_to do |format|
          if @poll.save
            format.html {redirect_to xmt_faq_polls_url, notice: '问卷调查添加成功.'}
            format.json {render :show, status: :created, location: @poll}
          else
            format.html {render :new}
            format.json {render json: @poll.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /polls/1
      # PATCH/PUT /polls/1.json
      def update
        params[:questions].each do |q|
          q.permit!
          s = q.delete('status')
          id = q.delete('id')
          if id
            qq = Question.find(id)
            s ? qq.destroy : qq.update(q)
          else
            @poll.questions.create(q)
          end
        end

        respond_to do |format|
          if @poll.update(poll_params)
            format.html {redirect_to xmt_faq_polls_url, notice: '问卷调查修改成功.'}
            format.json {render :show, status: :ok, location: @poll}
          else
            format.html {render :edit}
            format.json {render json: @poll.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /polls/1
      # DELETE /polls/1.json
      def destroy
        @poll.destroy
        respond_to do |format|
          format.html {redirect_to xmt_faq_polls_url, notice: '问卷调查删除成功.'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_poll
        @poll = Xmt::Faq::Poll.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def poll_params
        params.require(:xmt_faq_poll).permit!
      end

      def set_site
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
      end
    end
  end
end
