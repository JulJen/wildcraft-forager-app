class ProjectsController < ApplicationController
  before_action :require_logged_in
  before_action :authenticate_user, only: %i[new edit update destroy]

  def new
    @project = Project.new
    @team = Team.find_by_id(params[:team_id])
  end

  def create
    @team = Team.find_by_id(params[:team_id])
    if @team.team_admin == true
      @project = Project.new(project_params)
      if @project.save
        @team.projects << @project
        session[:success] = "Project created successfully!"
        redirect_to project_path(@project)
      else
        render :new
        # redirect_to new_team_project_path(@team)
      end
    end
  end


  def show
    @project = Project.find_by_id(params[:id])

    if !!@project
      @team = Team.find_by_id(@project.team_id)

      @team_admin = @current_user.id if @team.team_admin == true
      @current_members = @team.members

      @current_tasks = @project.tasks if @project.tasks

      if !!@current_tasks

        @filters = ["Status", "status"],["Updated At","formatted_updated_at", {:selected => "selected"}], ["Created At","formatted_created_at", {:selected => "selected"}]

        if params[:sort]
# raise params.inspect
          @tasks = Task.send(params[:sort][:filters])
          # @current_tasks = Task.order('?', params[:sort][:filters].parameterize.to_sym)
        # @project.tasks = Task.all(:order => 'updated_at DESC')
        else
          @tasks = Task.all
        end
      end
# binding.pry
      @task_success_message = session[:task_success]
      session[:task_success] = nil

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
    @team = Team.find_by_id(@project.team_id)
    if @project.team_id == @team.id
      @project.delete
    end
    session[:project_delete] = "Project deleted."
    redirect_to team_path(@team)
  end


  private

  def project_params
    params.require(:project).permit(:name, :description)
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
    @team = Team.find_by(user_id: current_user) if current_user
    @team.team_admin == true ? true : false
  end

end
