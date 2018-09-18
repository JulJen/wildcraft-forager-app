class SessionsController < ApplicationController

  def new
    @failure_message = session[:failure]
    session[:failure] = nil
    if !current_user
      @user = User.new
      @users = User.all
    else
      redirect_to current_user
    end
  end

  def create
binding.pry
    if !google_login?
      @user = User.find(params[:user][:name])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to current_user
      end
    elsif google_login?
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
        # make password secure
        u.password = auth['uid']
      end
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      session[:failure] = "Incorrect name and password, please try again."
      redirect_to signin_path
    end
  end

  # @user = User.find_or_create_by(uid: auth['uid']) do |u|
  #     u.name = auth['info']['name']
  #     u.email = auth['info']['email']
  #   end
  #   # self.current_user = @user
  #   session[:user_id] = @user.id
  #   # redirect_to @user
  #   redirect_to user_path(@user)
  # end

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

end
