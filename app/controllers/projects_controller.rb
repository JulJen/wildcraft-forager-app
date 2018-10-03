class ProjectsController < ApplicationController
  include ApplicationHelper
  before_action :require_logged_in
  # before_action :authenticate_user, only: %i[create update destroy]

  def index
    @user = current_user
    @projects = Project.all

    @project = Project.find_by_id(params[:user_id])
    @current_projects = current_user.projects

    if current_user.admin == true
      @admin_projects = current_user.projects
    else
      flash[:notice] = "You are not admin"
      redirect_to projects_path
    end
  end

  # def new
  #   @project = Project.new
  #   @categories = Category.all
  # end

  # def create
  #   @project = Project.new(project_params)
  #   if @project.save
  #     current_user.projects << @project
  #
  #     flash[:success] = "Project created successfully!"
  #     redirect_to project_path(@project)
  #   else
  #     render :new
  #   end
  # end

  def show
    @project = Project.find_by_id(params[:id])

    @current_members = current_user.memberships
    @current_posts = @project.posts

    if !!@current_posts
      @filters = [["Active", "active"], ["Inactive", "inactive"]]
      # @filters = [["Active", "active"],["Updated At","formatted_updated_at", {:selected => "selected"}], ["Created At","formatted_created_at", {:selected => "selected"}]]

      if params[:sort]
        # @tasks = Task.send(params[:sort][:filters])
        @current_post = @current_posts.send(params[:sort][:filters].parameterize.to_sym)
      # @project.tasks = Task.all(:order => 'updated_at DESC')
      else
        @current_posts
      end
    end
  end

  # def edit
  #   @project = Project.find_by_id(params[:id])
  # end

  # def update
  #   @project = Project.find_by_id(params[:id])
  #   if @project.update(project_params)
  #     redirect_to project_path(@project)
  #     flash[:update] = "Project succesfully updated!"
  #   else
  #     render :edit
  #   end
  # end
  #
  # def destroy
  #   @project = Project.find_by_id(params[:id])
  #   if @project.user_id == current_user.id
  #     @project.delete
  #   end
  #   flash[:deleted] = "Project deleted."
  #   redirect_to user_projects_path(current_user)
  # end

#   private
#
#   # def project_params
#   #   params.require(:project).permit(:name, :category_id)
#   # end
#
#   def authenticate_user
#     if logged_in?
#       unless is_admin?
#         redirect_to user_projects_path(current_user), flash[:error] = "you are not admin, change settings in profile" # halts request cycle
#       end
#     end
#   end
#
#   def is_admin?
#     # @project = Project.find_by_id(params[:id])
#     current_user.admin == true ? true : false
#   end
#
end
