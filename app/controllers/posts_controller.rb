class PostsController < ApplicationController
  before_action :require_logged_in
  before_action :authenticate_user, only: %i[update destroy]

  before_action :set_topic

  def index
    @posts = @topic.posts
    @current_posts = @topic.posts

    if !!@current_posts
      @filters = [["Active", "active"], ["Inactive", "inactive"], ["Recent Update","by_recent_update", {:selected => "selected"}]]

      if params[:sort]
        # @tasks = Task.send(params[:sort][:filters])
        @current_posts = @current_posts.send(params[:sort][:filters].parameterize.to_sym)
      # @topic.tasks = Task.all(:order => 'updated_at DESC')
      else
        @current_posts = @topic.posts.order(updated_at: :desc)
      end
    end

    respond_to do |f|
      f.html {render 'index.html', :layout => false}
      f.js {render 'index.js', :layout => false}
    end

  end


  def new
    @topic = Topic.find_by_id(params[:topic_id])
    @post = Post.new
  end

  def create
    @topic = Topic.find_by_id(params[:topic_id])
    @post = Post.new(post_params)
    if @post.save
      @topic.posts << @post

      flash[:success] = "Post created successfully!"
      redirect_to @topic
    else
      render :new
    end
  end


  def show
    @topic = Topic.find_by_id(params[:topic_id])
    @post = Post.find_by_id(params[:id])
  end



  def edit
    @post = Post.find_by_id(params[:id])
    @topic = Topic.find_by_id(@post.topic_id)
    unless is_admin?
      redirect_to topic_post_path(@topic, @post)
    end
  end



  def update
    @post = Post.find_by_id(params[:id])
    @topic = Topic.find_by_id(@post.topic_id)
    if @post.update(post_params)
      flash[:update] = "Post updated."
      redirect_to topic_path(@topic)
    else
      render :edit
    end
  end


  def destroy
    @post = Post.find_by_id(params[:id])
    @topic = Topic.find_by_id(@post.topic_id)
    # if @post.topic_id == @topic.id
      @post.delete
    # end
    flash[:notice] = "Post deleted."
    redirect_to @topic
  end


  private

  def set_topic
    @topic = Topic.find_by_id(params[:topic_id])
  end

  def post_params
    params.require(:post).permit(:name, :description, :status)
  end

  def authenticate_user
    if logged_in?
      unless is_admin?
        flash[:error] = "Sorry, admin access only."
      end
    end
  end

  def is_admin?
    @post = Post.find_by_id(params[:id])
    @topic = Topic.find_by_id(@post.topic_id)
    u = Membership.where(user_id: current_user.id, admin: true).distinct.pluck(:user_id)
    u_id = u.join(', ').to_i
    u_id == current_user.id
  end

end
