class UsersController < ApplicationController
  before_action :require_logged_in, except: %i[new create]


  def index
    @user = current_user
    @projects = Project.all
    @current_projects = current_user.projects

    if current_user.admin == true
      @admin_projects = current_user.projects
    else
      @member_projects = current_user.projects
    end
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
      flash[:success] = "User account created successfully!"
      redirect_to main_path
    else
      flash[:failure] = "Failure, user account not saved."
      render :new
    end
  end

  def show
    if params[:id].to_i == current_user.id
      render :show
    else
      redirect_to '/404'
    end
  end

  def member_show
    if !!params[:id]
      @member = User.grab_teammate(params[:id])
    else
      redirect_to '/404'
    end
  end

  def edit
    @user = current_user
    if params[:id].to_i == current_user.id
      render :edit
    else
      redirect_to '/404'
    end
  end

  def update
    if current_user.update(profile_params)
      redirect_to profile_path(current_user)
      flash[:success] = "Profile succesfully updated!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :admin)
  end

  def profile_params
    params.require(:user).permit(:language, :interest, :time_zone, :admin)
  end

end
