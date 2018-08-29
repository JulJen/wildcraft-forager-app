class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show, :index, :edit, :update, :destroy]

  def index
    # if logged_in?
    #   @user = current_user
    # else
    #   redirect_to root_path
    # end
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
        redirect_to user_path(@user.id)
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
    @success_message = session[:success]
    session[:success] = nil

    @incomplete_message = session[:incomplete]
    session[:incomplete] = nil
  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :username, :email, :password)
  end
end
