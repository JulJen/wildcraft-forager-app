class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :require_logged_in, :current_user


  def welcome
    clear_user
  end

  def enter
    clear_user
  end


  # def login_page
  #   if current_page?(:controller => 'application', :action => 'welcome')
  #   end
  # end

  def google_login?
    @url = request.path_info
    !!@url.include?('/auth/google_oauth2/callback')
    #   redirect_to '/auth/google_oauth2/callback'
    # end
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

  def user_teams
    @user_teams ||= Team.find_by_id(current_user) if current_user
  end

  def user_projects
    @user_projects ||= Project.find_by_id(current_user) if current_user
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


  def sign_in_incomplete?
    params[:user][:name] == "" || params[:user][:password] == ""
  end

end
