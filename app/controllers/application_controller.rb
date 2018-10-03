class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  helper_method :require_logged_in, :current_user, :find_user


  def clear_user
    @current_user = nil
    session.clear
  end

  def welcome
    clear_user
  end

  def enter
    clear_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def find_user
    # @user = User.find_by_id(current_user.id).id
    if !!current_user.id == params[:id].to_i
      redirect_to '/404'
    end
  end


  def logged_in?
    !!current_user
  end

  def require_logged_in
    if !logged_in?
      clear_user
      redirect_to welcome_path
    end
  end

  def google_login?
    !!request.path_info.include?('/auth/google_oauth2/callback')
  end


  def reset_session
    clear_user
    redirect_to signin_path
  end


  # def find_team
  #   @find_team = Team.find_by(user_id: current_user) if current_user
  # end

  # def url_path(url)
  #   @url_path = request.path_info if request.path_info.include?(url)
  # end

  # @current_teams.each {|team| request.path_info if request.path_info.include?('/team.id')}


  # private

  # def set_time_zone(&block)
  #    Time.use_zone(current_user.time_zone, &block)
  # end

end
