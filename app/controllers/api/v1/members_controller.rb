class Api::V1::MembersController < Api::V1::BaseController

  def show
    @member = Member.find(params[:id])
  end

  def login
    token = Waas::FormToken.new(params[:username], params[:password])
    if subject.login(token)
      render :json => {user: {user_id: subject.user_id, username: subject.username}, status: :ok}
    else
      render :json => {status: :sorry, notice:'', errors: ''}
    end
  end

  def logout
    subject.logout
    render :json => {status: :ok}
  end

  def register
    opts = {
        username: params[:username],
        password: params[:password],
        site_id: params[:site_id],
        email: params[:email],
        name: params[:name],
        id_no: params[:id_no],
        tel: params[:tel]
    }.delete_if {|k,v| v.blank?}
    @member = Member.new(opts)
    unless params[:group_sign]
      group = Group.where(sign: params[:group_sign]).first
      @member.groups = [group] if group
    end

    if @member.save
      render :json => {status: :ok, notice:'Member was successfully regist'}
    else
      render :json => {status: :sorry, notice:'unprocessable', errors: @member.errors}
    end
  end

end
