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

  # def select_member
  #   @select_member ||= TeamMember.find_by(session[:project_id]) if session[:project_id]
  # end

  def logged_in?
    !!current_user
  end

  def require_logged_in
    if !!logged_in?
      @user = current_user
    elsif !current_user
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


  def


# !params[:uid].present? &&

  def reset_session
    clear_user
    redirect_to enter_path
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

  def find_team
    @find_team = Team.find_by(user_id: current_user) if current_user
  end

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

  # def user_authenticate?
  #   if @user && @user.authenticate(params[:user][:password])
  #     current_user = @user
  #   end
  # end




end
