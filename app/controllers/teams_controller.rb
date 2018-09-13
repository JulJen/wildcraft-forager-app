class TeamsController < ApplicationController
  before_action :require_logged_in, except: %i[show]

  def index
    @teams = Team.find_by(user_id: session[:user_id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      current_user.teams << @team

      session[:success] = "Team created successfully!"
      redirect_to team_path(current_user)
    else
      session[:failure] = "Team could not be created, please try again."
      render :new
    end
  end

  def show
    @projects = Project.all
    @current_user = current_user

    @team = Team.find(params[:id])
    # @user = current_user

    @success_message = session[:success]
    session[:success] = nil

    @failure_message = session[:failure]
    session[:failure] = nil

    @incomplete_message = session[:incomplete]
    session[:incomplete] = nil

    render :show
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

  # private
  #
  def team_params
    params.require(:team).permit(:name)
  end
end
