class TeamsController < ApplicationController
  before_action :require_logged_in

  def index
    @current_teams = current_user.teams

    @team_success_message = session[:success_team]
    session[:success_team] = nil

    @team_deleted_message = session[:team_deleted]
    session[:team_deleted] = nil
  end

  def new
    # @failure_message = session[:failure]
    # session[:failure] = nil
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      current_user.teams << @team
      # @user.teams << @team

      session[:success_team] = "Team created successfully!"
      redirect_to user_teams_path(current_user)
    else
      # session[:failure] = "Team not saved, please try again."
      render :new
      # redirect_to new_user_team_path(current_user)
    end
  end

  def show
    require_logged_in
    # @projects = Project.all
    @current_teams = current_user.teams
    @team = Team.find_by_id(params[:id])

    @success_message = session[:success]
    session[:success] = nil

    render :show
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
