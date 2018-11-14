class TopicsController < ApplicationController
  include ApplicationHelper
  before_action :require_logged_in
  before_action :authenticate_user, only: %i[update destroy new_member]

  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @user = current_user
    @topic = Topic.find_by_id(params[:user_id])
    @current_topics = current_user.memberships

    @topics = Topic.all
    @categories = Category.all
  end

  def new
    @topic = Topic.new
    @categories = Category.all
  end

  def new_member
    @topic = Topic.find_by_id(params[:id])
    @users = User.active
    # @topic.memberships.create(topic: @topic, admin: false)
  end

  def create
    @topic = Topic.new(topic_params)
    if current_user.memberships.create(topic: @topic, admin: true)
      @topic.save
      # current_user.memberships.build(topic: @topic, admin: true)
      flash[:success] = "Admin: topic created successfully!"
      redirect_to  @topic
    else
      render :new
    end
  end


  def show
    @topic = Topic.find_by_id(params[:id])
    @admin_by_name = admin_by_name.capitalize

    @posts = @topic.posts
    @post = Post.new #@topic.posts.build

    @current_posts = @topic.posts

    @category_by_name = category_by_name if !!@topic.category_id
    @current_members = current_members

    @admin_invite = @current_members.empty? && is_admin?

    # if !!@current_posts
    #   @filters = [["Active", "active"], ["Inactive", "inactive"], ["Recent Update","by_recent_update", {:selected => "selected"}]]
    #
    #   if params[:sort]
    #     # @tasks = Task.send(params[:sort][:filters])
    #     @current_posts = @current_posts.send(params[:sort][:filters].parameterize.to_sym)
    #   # @topic.tasks = Task.all(:order => 'updated_at DESC')
    #   else
    #     @current_posts = @topic.posts.order(updated_at: :desc)
    #   end
    # end
  end


  def edit
    unless is_admin? == true
      redirect_to @topic
    end
    # @topic.memberships.where(user_id: current_user.id, admin: true)
  end


  def update
    @topic = Topic.find_by_id(params[:id])

# //new membership feature //
    if !topic_member_params.blank?
      @member = User.find_by_id(topic_member_params[:id])
      if @member != current_user
        @member.memberships.new(topic: @topic, admin: false)
        @member.save
      # current_user.memberships.build(topic: @topic, admin: true)
        flash[:success] = "Admin: new member added to topic!"
        redirect_to @topic
      else
        render :new_member
      end
# /END /new membership feature //

    elsif !topic_params.blank?
      @topic.update(topic_params)
        redirect_to  @topic
        flash[:update] = "Topic succesfully updated!"
    else
      render :edit
    end
  end


  def destroy
    @topic = Topic.find_by_id(params[:id])
    # if @topic.user_id == current_user.id
      @topic.delete
    # end
    flash[:deleted] = "Topic deleted."
    redirect_to topics_path
  end


  private

  def set_topic
    @topic = Topic.find_by_id(params[:id])
  end


  def topic_params
    params.require(:topic).permit(:name, :description, :category_id)
  end

  def authenticate_user
    if logged_in?
      unless is_admin?
        flash[:error] = "Sorry, admin access only."
      end
    end
  end

  # //new add_membership feature //
  def topic_member_params
    params.require(:topic).permit(:id)
  end

  def current_members
    @topic = Topic.find_by_id(params[:id])
    @current_members = Membership.where(topic_id: @topic, admin: false)
  end

  def member_by_name
    user  = @current_members.where( admin: false).pluck(:user_id)
    @member_by_name = User.find_by(id: user).name
  end
  #  // END //new add_membership feature //

  def is_admin?
    @topic = Topic.find_by_id(params[:id])
    user = Membership.where(user_id: current_user.id, admin: true).distinct.pluck(:user_id)
    @current_admin = user.join.to_i == current_user.id
    # @current_admin == @topic.memberships.map(&:user_id)
  end

  # def find_user_name(member)
  #   user = User.find_by_id(member.user_id)
  #   @find_user_name = user.name.capitalize
  # end

  # <%= link_to "#{find_user_name(member)}", show_member_path(member.user_id) %>
  #
  def admin_by_name
    admin_user = @topic.memberships.where(admin: true).pluck(:user_id)
    @admin_by_name = User.find_by(id: admin_user).name
  end

  # @topic = Topic.find_by_id(params[:id])
  # @admin = Membership.where(topic_id: @topic, user_id: current_user.id, admin: true).pluck(:user_id)


  def category_by_name
    category = Category.find_by_id(@topic.category_id)
    @category_by_name = category.name
  end

end
