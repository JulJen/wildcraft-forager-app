class UsersController < ApplicationController
  before_action :require_logged_in, except: %i[new create]

  def index
    @user = current_user
    @topics = Post.all
    @current_topics = @current_user.topics
  end


  def new
    if !current_user
      @user = User.new
    else
      redirect_to user_path(current_user)
    end
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

# //new membership feature //
  def show_member
    if !!params[:id]
      @member = User.grab_teammate(params[:id])
      render show_member
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
    if !profile_params_blank?
      if current_user.update(profile_params)
        current_user.update(status: true)
        flash[:success] = "Profile succesfully updated!"
        redirect_to profile_path(current_user)
      else
        render :edit
      end
    else
      flash[:notice] = "No changes saved. All fields were blank."
      redirect_to profile_path(current_user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def profile_params
    params.require(:user).permit( :time_zone, :country_code, :interest)
  end

  def profile_params_blank?
    profile_params[:time_zone].blank? && profile_params[:country_code ].blank? && profile_params[:interest].blank?
  end

end
