class ProjectsController < ApplicationController
  include ApplicationHelper
  before_action :require_logged_in
  before_action :authenticate_user, only: %i[update destroy new_member]


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

  def new_member
    @project = Project.find_by_id(params[:id])
    @users = User.active
    # @project.memberships.create(project: @project, admin: false)
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
    @admin_by_name = admin_by_name.capitalize

    @category_by_name = category_by_name if !!@project.category_id

    @current_posts = @project.posts
    @current_members = current_members

    @admin_invite = @current_members.empty? && is_admin?

    if !!@current_posts
      @filters = [["Active", "active"], ["Inactive", "inactive"], ["Recent Update","by_recent_update", {:selected => "selected"}]]

      if params[:sort]
        # @tasks = Task.send(params[:sort][:filters])
        @current_posts = @current_posts.send(params[:sort][:filters].parameterize.to_sym)
      # @project.tasks = Task.all(:order => 'updated_at DESC')
      else
        @current_posts = @project.posts.order(updated_at: :desc)
      end
    end
  end


  def edit
    unless is_admin? == true
      redirect_to @project
    end
    # @project.memberships.where(user_id: current_user.id, admin: true)
  end


  def update
    @project = Project.find_by_id(params[:id])

# //new membership feature //
    if !project_member_params.blank?
      @member = User.find_by_id(project_member_params[:id])
      if @member != current_user
        @member.memberships.new(project: @project, admin: false)
        @member.save
      # current_user.memberships.build(project: @project, admin: true)
        flash[:success] = "Admin: new member added to project!"
        redirect_to @project
      else
        render :new_member
      end
# /END /new membership feature //

    elsif !project_params.blank?
      @project.update(project_params)
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

  # //new add_membership feature //
  def project_member_params
    params.require(:project).permit(:id)
  end

  def current_members
    @project = Project.find_by_id(params[:id])
    @current_members = Membership.where(project_id: @project, admin: false)
  end

  def member_by_name
    user  = @current_members.where( admin: false).pluck(:user_id)
    @member_by_name = User.find_by(id: user).name
  end
  #  // END //new add_membership feature //

  def is_admin?
    @project = Project.find_by_id(params[:id])
    user = Membership.where(user_id: current_user.id, admin: true).distinct.pluck(:user_id)
    @current_admin = user.join.to_i == current_user.id
    # @current_admin == @project.memberships.map(&:user_id)
  end

  # def find_user_name(member)
  #   user = User.find_by_id(member.user_id)
  #   @find_user_name = user.name.capitalize
  # end

  # <%= link_to "#{find_user_name(member)}", show_member_path(member.user_id) %>

  def admin_by_name
    admin_user = @project.memberships.where(admin: true).pluck(:user_id)
    @admin_by_name = User.find_by(id: admin_user).name
  end

  # @project = Project.find_by_id(params[:id])
  # @admin = Membership.where(project_id: @project, user_id: current_user.id, admin: true).pluck(:user_id)


  def category_by_name
    category = Category.find_by_id(@project.category_id)
    @category_by_name = category.name
  end

end
