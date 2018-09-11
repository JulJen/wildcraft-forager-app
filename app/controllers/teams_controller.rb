class TeamsController < ApplicationController
  before_action :require_logged_in, only: [:new, :show, :edit, :update, :destroy]

  def index
    @teams = Team.all
    @user = current_user
  end

  def new
    @team = Team.new
  end

  def create
    if !team_params.empty?
      @team = Team.new(team_params)
      if @team.save
        session[:success] = "Team created successfully!"
        redirect_to team_path(@team)
      else
        session[:failure] = "Team could not be created, please try again."
        render 'new'
      end
    else
      session[:incomplete] = "Failure, fill out all fields."
      render 'new'
    end
  end



  def show
    if logged_in?
      @projects = Project.all
      @team = Team.find(session[:team_id])
      # @team = Team.find_by(params[:id])
      @user = current_user

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

  #
  # def edit
  #   @team = Team.find(params[:id])
  # end
  #
  # def update
  #   @team = Team.find(params[:id])
  #   if @team.update(attraction_params)
  #     redirect_to attraction_path(@team)
  #   else
  #     render 'new'
  #   end
  # end

  private

  def team_params
    params.require(:team).permit(:name)
  end

end
