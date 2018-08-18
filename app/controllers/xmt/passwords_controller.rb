class Xmt::PasswordsController < ApplicationController
  before_action :set_xmt_mgr_password, only: [:show, :edit, :update, :destroy]

  # GET /xmt/passwords
  # GET /xmt/passwords.json
  def index
    @xmt_mgr_passwords = Xmt::Password.all
  end

  # GET /xmt/passwords/1
  # GET /xmt/passwords/1.json
  def show
  end

  # GET /xmt/passwords/new
  def new
    @xmt_mgr_password = Xmt::Password.new
  end

  # GET /xmt/passwords/1/edit
  def edit
  end

  # POST /xmt/passwords
  # POST /xmt/passwords.json
  def create
    @xmt_mgr_password = Xmt::Password.new(xmt_mgr_password_params)

    respond_to do |format|
      if @xmt_mgr_password.save
        format.html { redirect_to @xmt_mgr_password, notice: 'Password was successfully created.' }
        format.json { render :show, status: :created, location: @xmt_mgr_password }
      else
        format.html { render :new }
        format.json { render json: @xmt_mgr_password.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /xmt/passwords/1
  # PATCH/PUT /xmt/passwords/1.json
  def update
    respond_to do |format|
      if @xmt_mgr_password.update(xmt_mgr_password_params)
        format.html { redirect_to @xmt_mgr_password, notice: 'Password was successfully updated.' }
        format.json { render :show, status: :ok, location: @xmt_mgr_password }
      else
        format.html { render :edit }
        format.json { render json: @xmt_mgr_password.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /xmt/passwords/1
  # DELETE /xmt/passwords/1.json
  def destroy
    @xmt_mgr_password.destroy
    respond_to do |format|
      format.html { redirect_to xmt_mgr_passwords_url, notice: 'Password was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_xmt_mgr_password
      @xmt_mgr_password = Xmt::Password.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def xmt_mgr_password_params
      params.fetch(:xmt_mgr_password, {})
    end
end
