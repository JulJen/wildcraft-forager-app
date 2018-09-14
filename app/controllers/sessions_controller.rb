class SessionsController < ApplicationController

  def new
    @failure_message = session[:failure]
    session[:failure] = nil

    clear_user
    @user = User.new
    @users = User.all
  end

  def create
    if !google_login? && signin_valid?
      @user = User.find(params[:user][:name])
      if user_authenticate?
        session[:user_id] = @user.id
        redirect_to dashboard_path
      end
    elsif google_login?
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
        # make password secure
        u.password = auth['uid']
      end
      session[:user_id] = @user.id
      redirect_to dashboard_url
    elsif !signin_valid?
      session[:failure] = "Account not saved, please try again."
      redirect_to signin_path
    end

  end

  def destroy
    reset_session
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def auth
    request.env['omniauth.auth']
  end

end
