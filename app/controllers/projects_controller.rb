class ProjectsController < ApplicationController
  before_action :require_logged_in

  def index
    @projects = Project.where("team_id = ?", params[:team_id])
    @user = current_user
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

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

end
