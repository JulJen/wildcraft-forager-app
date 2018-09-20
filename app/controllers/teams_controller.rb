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
      redirect_to user_teams_path(current_user)
    else
      render :new
    end
  end

  def show
    @current_teams = current_user.teams
    @team = Team.find_by_id(params[:id])

    @team_admin_id = @current_user.id if @team.team_admin == true

    @success_message = session[:success]
    session[:success] = nil

    @project_delete_message = session[:project_delete]
    session[:project_delete] = nil
  end

  def edit
    @team = Team.find_by_id(params[:id])
  end

  def update
    @team = Team.find_by(user_id: current_user)
    if @team.update(team_params)
      redirect_to team_path(@team)
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
    params.require(:team).permit(:name, :team_admin)
  end
end
