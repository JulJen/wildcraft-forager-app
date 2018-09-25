class TeamsController < ApplicationController
  before_action :require_logged_in
  before_action :authenticate_user, only: %i[edit update destroy]

  def index
    @teams = Team.all
    @team = Team.find_by_id(params[:id])
    @current_teams = current_user.teams
    @current_projects = current_user.projects


    @team_success_message = session[:success_team]
    session[:success_team] = nil

    @team_deleted_message = session[:team_deleted]
    session[:team_deleted] = nil
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      current_user.teams << @team

      session[:success_team] = "Team created successfully!"
      redirect_to team_path(@team)
    else
      render :new
    end
  end

  def show
    @team = Team.find_by_id(params[:id])
    @current_teams = current_user.teams

    @current_projects = @team.projects
    @current_members = @team.members

    @team_admin = @current_user.id if @team.team_admin == true

    @success_message = session[:success]
    session[:success] = nil

    @project_delete_message = session[:project_delete]
    session[:project_delete] = nil

    @team_update_message = session[:team_update]
    session[:team_update] = nil

    @member_success_message = session[:member_success]
    session[:member_success] = nil
  end

  def edit
    @team = Team.find_by_id(params[:id])

    @admin_error_message = session[:admin_error]
    session[:admin_error] = nil
  end

  def update
    @team = Team.find_by_id(params[:id])
    if @team.update(team_params)
      redirect_to team_path(@team)
      session[:team_update] = "Team succesfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @team = Team.find_by_id(params[:id])
    if @team.user_id == current_user.id
      @team.delete
    end
    session[:team_deleted] = "Team deleted."
    redirect_to user_teams_path(current_user)
  end

  private

  def team_params
    params.require(:team).permit(:name, :industry_id, :team_admin)
  end

  def authenticate_user
    if logged_in?
      unless is_admin?
        session[:admin_error] = "You are not admin of this team"
        redirect_to edit_team_path(@team) # halts request cycle
      end
    end
  end

  def is_admin?
    @team = Team.find_by_id(params[:id])
    @team.team_admin == true ? true : false
  end

end
