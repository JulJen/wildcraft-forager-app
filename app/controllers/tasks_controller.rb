class TasksController < ApplicationController
  before_action :require_logged_in

  def index
    @filter_tasks = ["Name", "Updated At", "Status"]
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
    if @team.team_admin == true
      @task = Task.new(task_params)
      if @task.save
        @project.tasks << @task

        session[:task_success] = "Task added."
        redirect_to project_path(@project)
      else
        session[:failure] = "Task could not be created, please try again."
        render :new
      end
    end
  end


  def show
    @team = Team.find_by(user_id: current_user)
    @project = Project.find_by_id(params[:project_id])
    @task = Task.find_by_id(params[:id])
  end


  def edit
    @project = Project.find_by_id(params[:project_id])
    @team = Team.find_by_id(@project.team_id)


    @task = Task.find_by_id(params[:id])



    @admin_error_message = session[:admin_error]
    session[:admin_error] = nil
  end

  def update
    @team = Team.find_by_id(params[:id])
    @task = Task.find_by_id(params[:id])
    @project = Project.find_by_id(@task.project_id)

    if @task.update(task_params)
      redirect_to project_path(@project)

      session[:task_update] = "Task updated!"
    else
      render :edit
    end
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
    params.require(:task).permit(:name, :status)
  end

end
