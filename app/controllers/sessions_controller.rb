class SessionsController < ApplicationController

  def new
    @user = User.new
    @users = User.all

    @failure_message = session[:failure]
    session[:failure] = nil

    @incomplete_message = session[:incomplete]
    session[:incomplete] = nil
  end

  def create
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      # make password secure
      u.password = auth['uid']
    end
    # self.current_user = @user
    session[:user_id] = @user.id
    # redirect_to @user
    redirect_to '/dashboard'
  end

  #   if !logged_in? && !sign_in_incomplete?
  #     @user = User.find(params[:user][:username])
  #     if @user && @user.authenticate(params[:user][:password])
  #       session[:user_id] = @user.id
  #       # redirect_to @user
  #       redirect_to user_path(@user)
  #     else
  #       session[:failure] = "Account not saved, please try again."
  #       render 'new'
  #     end
  #   else
  #     session[:incomplete] = "Failure, fill out all fields."
  #     render 'new'
  #   end
  # end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
