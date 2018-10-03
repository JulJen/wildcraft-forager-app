class CategoriesController < ApplicationController
  before_action :require_logged_in

  def index
    @user = current_user
    @categories = Category.all

    @teams = Team.all
    @projects = Project.all
    @users = User.all

    # @current_teams = current_user.teams
    # @current_projects = current_user.projects
  end

  def show
    @category = Category.find_by_id(params[:id])
    @industry = @category.industry_name
    @team = Team.find_by_id(params[:team_id])

    @current_teams = current_user.teams

  end

end
