class UsersController < ApplicationController
  before_action :require_logged_in, except: %i[new create]

  def index

  end

  def new
    if !current_user
      @user = User.new
      @failure_message = session[:failure]
      session[:failure] = nil
    else
      redirect_to user_path(current_user)
    end

    @siginin_failure_message = session[:failure]
    session[:failure] = nil
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      session[:success] = "User account created successfully!"
      redirect_to main_path
    else
      session[:failure] = "Failure, user account not saved."
      render :new
    end
  end

  def show
    if params[:id].to_i == current_user.id
        # @current_teams = current_user.teams
        # @current_projects = current_user.projects
        @success_message = session[:success]
        session[:success] = nil
    else
      redirect_to '/404'
    end
  end

  def member_show
    if !!params[:id]
      @team_member = User.grab_teammate(params[:id])
      # render :member_show
    else
      redirect_to '/404'
    end
  end

  def edit
  end

  def update
    if current_user.update(profile_params)
      redirect_to profile_path(current_user)
      session[:user_update] = "Profile succesfully updated!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def profile_params
    params.require(:current_user).permit(:language, :gender, :interest, :time_zone)
  end

end
