class PublicTeamsController < ApplicationController
  before_action :require_logged_in

  def index
    @teams = Team.all
    @projects = Project.all

    @current_teams = current_user.teams
    @current_projects = current_user.projects
  end

  def show
    @current_teams = current_user.teams
    @team = Team.find_by_id(params[:id])
  end

end
