class PostsController < ApplicationController
  before_action :require_logged_in
  # before_action :authenticate_user, only: %i[new edit update destroy]

  def new
    @project = Project.find_by_id(params[:project_id])
    @post = Post.new
  end

  def create
    @project = Project.find_by_id(params[:project_id])
    @post = Post.new(post_params)
    if @post.save
      @project.posts << @post

      session[:success] = "Post created successfully!"
      redirect_to @project
    else
      render :new
    end
  end


  def show
    @project = Project.find_by_id(params[:project_id])
    @post = Post.find_by_id(params[:id])
  end



  def edit
    @post = Post.find_by_id(params[:id])
    @project = Project.find_by_id(@post.project_id)
  end



  def update
    @post = Post.find_by_id(params[:id])
    @project = Project.find_by_id(@post.project_id)
    if @post.update(post_params)
      session[:update] = "Post updated."
      redirect_to project_path(@project)
    else
      render :edit
    end
  end


  def destroy
    @post = Post.find_by_id(params[:id])
    @project = Project.find_by_id(@post.project_id)
    # if @post.project_id == @project.id
      @post.delete
    # end
    flash[:notice] = "Post deleted."
    redirect_to @project
  end


  private

  def post_params
    params.require(:post).permit(:name, :description, :status)
  end

  # def authenticate_user
  #   if !!logged_in?
  #     unless !!is_admin?
  #       flash[:error] = "You are not admin of this project"
  #       redirect_to project_path(@project) # halts request cycle
  #     end
  #   end
  # end
  #
  # def is_admin?
  #   # @team = Team.find_by(user_id: current_user) if current_user
  #   current_user.admin == true ? true : false
  # end

end
