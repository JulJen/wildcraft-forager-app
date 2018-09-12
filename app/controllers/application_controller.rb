class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :require_logged_in


  def welcome
    @current_user = nil
    session.clear
  end


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def user_authenticate?
    if @user && @user.authenticate(params[:user][:password])
      @user = current_user
    end
  end

  def require_logged_in
    if logged_in?
      @user = @current_user
    else
      redirect_to root_path
    end
  end

  def sign_in_incomplete?
    params[:user][:name] == "" || params[:user][:password] == ""
  end

  def reset_session
    @current_user = nil
    session.clear
  end

end
