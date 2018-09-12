class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show, :index, :edit, :update, :destroy]
  # before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @user = User.new
  end

  def create
    if !user_params.empty?
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        session[:success] = "User account created successfully!"
        @current_user = current_user
        redirect_to '/dashboard'
        # redirect_to user_path(@current_user)
      else
        session[:failure] = "Failure, user account not saved."
        render 'new'
      end
    else
      session[:incomplete] = "Failure, fill out all fields."
      render 'new'
    end
  end

  def show
    # @user = User.friendly.find(params[:id])
    # @user = User.friendly.find(session[:user_id])
    if logged_in?
      # @user = User.find(session[:user_id])
      # @user = User.find_by_id(current_user)
      @user = User.find_by(name: params[:name])
      @current_user = current_user

      @success_message = session[:success]
      session[:success] = nil

      @failure_message = session[:failure]
      session[:failure] = nil

      @incomplete_message = session[:incomplete]
      session[:incomplete] = nil

      render :show
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  # def set_user
  #   @user = User.friendly.find(params[:id])
  #   redirect_to action: action_name, id: @user.friendly_id, status: 301 unless @user.friendly_id == params[:id]
  # end
end
