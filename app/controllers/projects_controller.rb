class ProjectsController < ApplicationController
  before_action :require_logged_in

  def index
binding.pry
    @current_teams = current_user.teams
    # @projects = Project.where("team_id = ?", params[:team_id])

    @delete_message = session[:delete]
    session[:delete] = nil
  end

  def new
    @project = Project.new
    @team = Team.find_by(user_id: current_user)
  end

  def create
binding.pry
    @team = Team.find_by(user_id: current_user)
    @project = Project.new(project_params)
    if current_user && @project.save
      @team.projects << @project
      session[:success] = "Project created successfully!"
      redirect_to new_team_project_path(@team, @project)
    else
      session[:failure] = "Project could not be created, please try again."
      render 'new'
    end
  end


  def show
    if logged_in?
      # @team = Team.find(session[:user_id])
      # @project = Project.find(session[:user_id])
      @user = current_user

      @success_message = session[:success]
      session[:success] = nil

      @failure_message = session[:failure]
      session[:failure] = nil

      @incomplete_message = session[:incomplete]
      session[:incomplete] = nil
    else
      redirect_to root_path
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def destroy
    @project = Project.find_by_id(params[:id])
    if @project.user_id == current_user.id
      @project.delete
    end
    session[:delete] = "Project deleted."
    redirect_to user_projects_path(current_user)
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

end
