class TasksController < ApplicationController
  before_action :require_logged_in

  def index
    @project = Project.find_by_id(params[:project_id])
  end


  def new
    @project = Project.find_by_id(params[:project_id])
    @team = Team.find_by(user_id: current_user)
    @task = Task.new
  end


  def create
    @team = Team.find_by(user_id: current_user)
    @project = Project.find_by_id(params[:project_id])
    @task = Task.new(task_params)
    if @team.team_admin == true
      @task.save
      @project.tasks << @task

      redirect_to project_path(@project)
    else
      session[:failure] = "Project could not be created, please try again."
      render :new
    end
  end


  def show
    @team = Team.find_by(user_id: current_user)
    @project = Project.find_by_id(params[:project_id])
    @task = Task.find_by_id(params[:id])
  end


  def destroy
    @team = Team.find_by(user_id: current_user)
    @project = Project.find_by_id(params[:project_id])
    @task = Task.find_by_id(params[:id])

    if @task.project_id == @project.id
      @task.delete
    end
    redirect_to project_tasks_path(@project.id)
  end



  private

  def task_params
    params.require(:task).permit(:comment)
  end

end
