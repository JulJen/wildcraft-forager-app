class TeamMembersController < ApplicationController

  def index
    @team = Team.find_by(user_id: current_user)
    @project = Project.find_by_id(params[:project_id])
    @team_member = TeamMember.new
    @current_members = @project.team_members
    # @users = User.all
  end

  def new
    @team_member = TeamMember.new
    @team = Team.find_by(user_id: current_user)
    @project = Project.find_by_id(params[:project_id])
  end

  def create
binding.pry
    @team = Team.find_by(user_id: current_user)
    @project = Project.find_by_id(params[:project_id])
    @team_member= TeamMember.new(member_params)
    if @project.project_admin == true
      if @team_member.save
        @project.team_members << @team_member
        session[:success] = "Project created successfully!"
        redirect_to project_path(@project)
      end
    else
      session[:failure] = "Invitation failed, please try again."
      render :new
    end
  end

  def show
    @team = Team.find_by(user_id: current_user)
    @project = Project.find_by_id(params[:project_id])
    @team_member = TeamMember.find_by_id(params[:id])
    @current_members = @project.team_members
  end

  def destroy
  end

  private

  def member_params
    params.require(:team_member).permit(:name, :team_admin_id, :project_id)
  end

end
