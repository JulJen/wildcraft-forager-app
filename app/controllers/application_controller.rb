class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :require_logged_in, :current_user

  # <%= form_for  @user, as: :user, url: signup_path do |f| %>


  def welcome
    clear_user
  end

  def enter
    clear_user
  end

  def google_login?
    @url = request.path_info
    !!@url.include?('/auth/google_oauth2/callback')
    #   redirect_to '/auth/google_oauth2/callback'
    # end
  end

  def current_url
    path = request.path_info
    @url = path.include?(request.path_info)
  end

# !params[:uid].present? &&

  def clear_user
    @current_user = nil
    session.clear
  end

  def reset_session
    clear_user
    redirect_to enter_path
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_teams
    @current_teams = current_user.teams if current_user
  end

  def current_projects
    @current_projects = current_user.projects if current_user
  end

  def logged_in?
    !!current_user
  end

  def user_authenticate?
    if @user && @user.authenticate(params[:user][:password])
      current_user = @user
    end
  end

  def require_logged_in
    if !!logged_in?
      @user = current_user
    end
  end


  def signin_valid?
    !params[:user][:name] == "" || !params[:user][:password] == ""
  end

  def signup_valid?
    !params[:user][:name] == "" || !params[:user][:email] == "" || !params[:user][:password] == ""
  end

end
