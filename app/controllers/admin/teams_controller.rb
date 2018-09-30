class Admin::TeamsController < ApplicationController
  include ApplicationHelper
  before_action :require_logged_in
  before_action :current_user
  before_action :authenticate_user, only: %i[create update destroy]

  def index
    @user = current_user
    @team = Team.find_by_id(params[:user_id])

    if !!@team_admin
      @admin_teams = current_user.teams
    else
      flash[:notice] = "You are not admin"
      redirect_to teams_path
    end
  end

  def new
    @team = Team.new
    @categories = Category.all

  end

  def create
    @team = Team.new(team_params)
    if @team.save
      current_user.teams << @team

      flash[:success] = "Team created successfully!"
      redirect_to admin_team_path(@team)
    else
      render :new
    end
  end

  def show
    @team = Team.find_by_id(params[:id])
    @current_members = current_user.memberships
    # @team_enrollments ||= @team.team_enrollments if !!@team.team_enrollments

    @current_teams = current_user.teams
    @current_projects = @team.projects
  end

  def edit
    @team = Team.find_by_id(params[:id])
  end

  def update
    @team = Team.find_by_id(params[:id])
    if @team.update(team_params)
      redirect_to team_path(@team)
      flash[:update] = "Team succesfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @team = Team.find_by_id(params[:id])
    if @team.user_id == current_user.id
      @team.delete
    end
    flash[:deleted] = "Team deleted."
    redirect_to user_teams_path(current_user)
  end

  private

  def team_params
    params.require(:team).permit(:name, :category_id)
  end

  def authenticate_user
    if logged_in?
      unless is_admin?
        redirect_to user_teams_path(current_user), flash[:error] = "you are not admin, change settings in profile" # halts request cycle
      end
    end
  end

  def is_admin?
    # @team = Team.find_by_id(params[:id])
    current_user.team_admin == true ? true : false
  end

end
