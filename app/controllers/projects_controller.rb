class ProjectsController < ApplicationController
  before_action :require_logged_in
  before_action :authenticate_user, only: %i[edit update destroy]

  def index
    @team = Team.find_by(user_id: current_user)
    @current_projects = current_user.projects
  end

  def new
    @project = Project.new
    @team = Team.find_by_id(params[:team_id])
  end

  def create
    @team = Team.find_by_id(params[:team_id])
    @project = Project.new(project_params)
    if @team.team_admin == true
      @project.save
      @team.projects << @project
      session[:success] = "Project created successfully!"
      redirect_to project_path(@project)
    else
      session[:failure] = "Project could not be created, please try again."
      render :new
    end
  end


  def show
    @project = Project.find_by_id(params[:id])

    if !!@project
      @team = Team.find_by_id(@project.team_id)

      @project_admin_id = @current_user.id if @project.project_admin == true
      @current_members = @project.team_members

      @success_message = session[:success]
      session[:success] = nil
    else
      redirect_to '/404'
    end
  end

  def edit
    @project = Project.find_by_id(params[:id])
  end

  def update
    @project = Project.find_by_id(params[:id])
    if @project.update(project_params)
      redirect_to @project
    else
      render :edit
    end
  end


  def destroy
    @project = Project.find_by_id(params[:id])
    @team = Team.find_by(user_id: current_user)
    if @project.team_id == @team.id
      @project.delete
    end
    session[:project_delete] = "Project deleted."
    redirect_to team_projects_path(@team)
  end


  private

  def project_params
    params.require(:project).permit(:name, :description, :team_admin_id, :project_admin)
  end

  def authenticate_user
    if !!logged_in?
      unless !!is_admin?
        session[:admin_error] = "You are not admin of this project"
        redirect_to edit_project_path(@project) # halts request cycle
      end
    end
  end

  def is_admin?
    @project = Project.find_by_id(params[:id]) if !!params[:id]
    @project.project_admin == true ? true : false
  end

end
