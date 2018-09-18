class ProjectsController < ApplicationController
  before_action :require_logged_in

  def index
    @team = Team.find_by(user_id: current_user)
    @current_projects = current_user.projects
    # @projects = Project.where("team_id = ?", params[:team_id])
  end

  def new
    # @failure_message = session[:failure]
    # session[:failure] = nil
    @project = Project.new
    # @team = Team.find_by_id(params[:id])
    @team = Team.find_by(user_id: current_user)
  end

  def create
    @team = Team.find_by(user_id: current_user)
    @project = Project.new(project_params)
    if @project.save
      @team.projects << @project
      session[:success] = "Project created successfully!"
      redirect_to project_path(@project)
    else
      session[:failure] = "Project could not be created, please try again."
      render :new
    end
  end


  def show
    if logged_in?
      @user = current_user
      @team = Team.find_by(user_id: current_user)
      @project = Project.find_by_id(params[:id])

      @success_message = session[:success]
      session[:success] = nil

      render :show
    else
      redirect_to root_path
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
binding.pry
    @project = Project.find_by_id(params[:id])
    @team = Team.find_by(user_id: current_user)
    if @project.team_id == @team.id
      @project.delete
    end
    session[:project_delete] = "Project deleted."
    redirect_to team_projects_path(@team, @project)
  end


  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

end
