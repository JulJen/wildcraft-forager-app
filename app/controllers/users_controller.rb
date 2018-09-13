class UsersController < ApplicationController
  before_action :require_logged_in, except: %i[new create]

  def index
  end

  def new
    clear_user
    @user = User.new

    @failure_message = session[:failure]
    session[:failure] = nil
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      session[:success] = "User account created successfully!"
      redirect_to '/dashboard'
    else
      session[:failure] = "Failure, user account not saved."
      render :new
    end
  end

  def show
    # @user = User.find(session[:user_id])
    @success_message = session[:success]
    session[:success] = nil
  end

  private

  def user_params
    params.require(signup_path).permit(:name, :email, :password)
  end

  # def set_user
  #   @user = User.friendly.find(params[:id])
  #   redirect_to action: action_name, id: @user.friendly_id, status: 301 unless @user.friendly_id == params[:id]
  # end
end
