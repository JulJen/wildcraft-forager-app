class TeamsController < ApplicationController
  before_action :require_logged_in, except: %i[show]

  def index
    @current_teams = current_user.teams

    @team_deleted_message = session[:team_deleted]
    session[:team_deleted] = nil
  end

  def new
    # @failure_message = session[:failure]
    # session[:failure] = nil
    @team = Team.new
    # @project = Project.new
  end

  def create
binding.pry
    @team = Team.new(team_params)
    if @team.save
      @user.teams << @team

      session[:success] = "Team created successfully!"
      redirect_to user_team_path(current_user, @team)
    else
      session[:failure] = "Team not saved, please try again."
      render :new
      # redirect_to new_user_team_path(current_user)
    end
  end

  def show
    # @projects = Project.all
    @current_teams = current_user.teams
    @team = Team.find_by_id(params[:id])

    @success_message = session[:success]
    session[:success] = nil

    render :show
  end

  def destroy
    @team = Team.find_by(user_id: current_user)
    # @team = Team.find_by_id(params[:id])
    if @team.user_id == current_user.id
      @team.delete
    end
    session[:team_deleted] = "Team deleted."
    redirect_to current_teams_path(current_user)
  end

  def edit
    # @team = Team.find(params[:id])
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

  private

  def team_params
    params.require(:team).permit(:name, :team_admin)
  end
end
