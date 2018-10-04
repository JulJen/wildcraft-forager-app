class ProjectsController < ApplicationController
  include ApplicationHelper
  before_action :require_logged_in
  before_action :authenticate_user, only: %i[update destroy]

  def index
    @user = current_user

    @project = Project.find_by_id(params[:user_id])

    @current_projects = current_user.memberships

    @projects = Project.all
    @categories = Category.all
  end

  def new
    @project = Project.new
    @categories = Category.all
  end

  def create
    @project = Project.new(project_params)
    if current_user.memberships.create(project: @project, admin: true)
      @project.save
      # current_user.memberships.build(project: @project, admin: true)
      flash[:success] = "Admin: project created successfully!"
      redirect_to  @project
    else
      render :new
    end
  end

  def show
    @project = Project.find_by_id(params[:id])

    @admin_by_name = admin_by_name.capitalize if @project.memberships.any?
    @category_by_name = category_by_name if !!@project.category_id

    @current_members = current_user.memberships

    @current_projects = current_user.projects
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


binding.pry
  end


  def edit
    unless is_admin?
      redirect_to @project
    end
    # @project.memberships.where(user_id: current_user.id, admin: true)
  end


  def update
    @project = Project.find_by_id(params[:id])
    if @project.update(project_params)
      redirect_to  @project
      flash[:update] = "Project succesfully updated!"
    else
      render :edit
    end
  end


  def destroy
    @project = Project.find_by_id(params[:id])
    # if @project.user_id == current_user.id
      @project.delete
    # end
    flash[:deleted] = "Project deleted."
    redirect_to projects_path
  end


  private

  def project_params
    params.require(:project).permit(:name, :description, :category_id)
  end

  def authenticate_user
    if logged_in?
      unless is_admin?
        flash[:error] = "Sorry, admin access only."
      end
    end
  end

  def is_admin?
    @project = Project.find_by_id(params[:id])
    @current_admin = Membership.where(user_id: current_user.id, admin: true).distinct.pluck(:user_id)
    @current_admin == @project.memberships.map(&:user_id)
  end

  def find_user_name
    user  = @project.memberships.pluck(:user_id)
    @find_user = User.find_by(id: user)
    @find_user.name
  end

  def member_by_name
    user  = @project.memberships.where(admin: false).pluck(:user_id)
    @member_by_name = User.find_by(id: user).name
  end

  def admin_by_name
    admin_user = @project.memberships.where(admin: true).pluck(:user_id)
    @admin_by_name = User.find_by(id: admin_user).name
  end

  def category_by_name
    category = Category.find_by_id(@project.category_id)
    @category_by_name = category.name
  end

end
