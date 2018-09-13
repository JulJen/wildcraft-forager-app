class ProjectsController < ApplicationController
  before_action :require_logged_in

  def index
    @projects = Project.where("team_id = ?", params[:team_id])

    @delete_message = session[:delete]
    session[:delete] = nil
  end

  def new
    @user = current_user
    @project = Project.new
    @team = Team.find_by(id: params[:team_id])
  end

  def create
binding.pry
    if !project_params.empty?
      @project = Project.new(project_params)
      if @project.save
        session[:success] = "Project created successfully!"
        redirect_to new_team_project_path(@project)
      else
        session[:failure] = "Project could not be created, please try again."
        render 'new'
      end
    else
      session[:incomplete] = "Failure, fill out all fields."
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
