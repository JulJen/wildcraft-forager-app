class SessionsController < ApplicationController

  def new
    @login_failure_message = session[:login_failure]
    session[:login_failure] = nil

    if !current_user
      @user = User.new
      @users = User.all
    else
      redirect_to current_user
    end
  end

  def create
    if !google_login?
      if !params_valid? == false
        @user = User.find(params[:user][:name])
        if @user && @user.authenticate(params[:user][:password])
          session[:user_id] = @user.id
          redirect_to main_path
        end
      else
        session[:login_failure] = "Incorrect name and password, please try again."
        redirect_to signin_path
      end
    elsif google_login?
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
        # make password secure
        u.password = auth['uid']
      end
      session[:user_id] = @user.id
      redirect_to main_path
    end
  end




  def destroy
    reset_session
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end

  def auth
    request.env['omniauth.auth']
  end

  def params_valid?
    user_params[:name].present? && user_params[:password].present?
  end

end
