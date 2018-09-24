module UsersHelper
  def not_found
    render :status => 404
  end

  def unacceptable
    render :status => 422
  end

  def internal_error
    render :status => 500
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :require_logged_in, :current_user

  # <%= form_for  @user, as: :user, url: signup_path do |f| %>

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

  def team_member
    if !params[:id] == current_user.id
      @team_member = User.grab_teammate(params[:id])
    end
  end


  # def select_member
  #   @select_member ||= TeamMember.find_by(session[:project_id]) if session[:project_id]
  # end

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


  def team_admin
    @current_teams.each {|team| @team_admin = team.team_admin if team.team_admin == 'true'}
  end

  def project_admin
    @current_projects.each {|p| @project_admin = p.project_admin if p.project_admin == 'true'}
  end

  def team_admin_id
    @team_admin_id = @current_user.id if @team.team_admin == true
  end

  def project_admin_id
    @project_admin_id = @current_user.id if @project.project_admin == true
  end

# !params[:uid].present? &&

  def reset_session
    clear_user
    redirect_to signin_path
  end

  def my_team
    @my_team = Team.find_by_id(params[:id]) if current_user
  end


  def current_teams
    @current_teams = current_user.teams if current_user
  end

  def current_projects
    @current_projects = current_user.projects if current_user
  end

  def current_members
    @current_members = @project.team_members if @project
  end

  # def find_team
  #   @find_team = Team.find_by(user_id: current_user) if current_user
  # end

  # def url_path(url)
  #   @url_path = request.path_info if request.path_info.include?(url)
  # end

  # @current_teams.each {|team| request.path_info if request.path_info.include?('/team.id')}

  def signin_valid?
    !params[:user][:name] == "" || !params[:user][:password] == ""
  end

  def signup_valid?
    !params[:user][:name] == "" || !params[:user][:email] == "" || !params[:user][:password] == ""
  end

  private

  def set_time_zone(&block)
     Time.use_zone(current_user.time_zone, &block)
  end

end
