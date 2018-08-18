module Xmt
  module Faq
    class ConsultationsController < AdminController
      before_action :set_consultation, only: [:show, :edit, :update, :destroy]
      before_action :set_site
      # GET /xmt/faq/consultations
      # GET /xmt/faq/consultations.json
      def index
        opts = {}
        opts[:site_id] = params[:site_id].blank? ? @site.id : params[:site_id]
        opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?
        opts[:checked] = params[:checked] unless params[:checked].blank?
        @consultations = Xmt::Faq::Consultation.where(opts).order(id: :desc).page(params[:page])

      end

      # GET /xmt/faq/consultations/1
      # GET /xmt/faq/consultations/1.json
      def show
      end

      # GET /xmt/faq/consultations/new
      def new
        @consultation = Xmt::Faq::Consultation.new
      end

      # GET /xmt/faq/consultations/1/edit
      def edit
      end

      # POST /xmt/faq/consultations
      # POST /xmt/faq/consultations.json
      def create
        @consultation = Xmt::Faq::Consultation.new(consultation_params)

        respond_to do |format|
          if @consultation.save
            format.html {redirect_to xmt_faq_consultations_path(site_id: @site.id), notice: '添加成功.'}
            format.json {render :show, status: :created, location: @consultation}
          else
            format.html {render :new}
            format.json {render json: @consultation.errors, status: :unprocessable_entity}
          end
        end
      end

      # PATCH/PUT /xmt/faq/consultations/1
      # PATCH/PUT /xmt/faq/consultations/1.json
      def update
        respond_to do |format|
          if @consultation.update(consultation_params)
            format.html {redirect_to xmt_faq_consultations_path(site_id: @site.id), notice: '编辑成功.'}
            format.json {render :show, status: :ok, location: @consultation}
          else
            format.html {render :edit}
            format.json {render json: @consultation.errors, status: :unprocessable_entity}
          end
        end
      end

      # DELETE /xmt/faq/consultations/1
      # DELETE /xmt/faq/consultations/1.json
      def destroy
        @consultation.destroy
        respond_to do |format|
          format.html {redirect_to xmt_faq_consultations_path(site_id: @site.id), notice: '删除成功.'}
          format.json {head :no_content}
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_consultation
        @consultation = Xmt::Faq::Consultation.find(params[:id])
      end

      def set_site
        @sites = Xmt::Press::Site.all
        @site = params[:site_id].blank? ? @sites.first : Xmt::Press::Site.find(params[:site_id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def consultation_params
        params.require(:xmt_faq_consultation).permit!
      end
    end
  end
end