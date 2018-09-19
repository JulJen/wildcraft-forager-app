class TeamMembersController < ApplicationController

  def index
    @team_member = TeamMember.new

    @team = Team.find_by(user_id: current_user)
    if !!params[:project_id]
      @project = Project.find_by_id(params[:project_id])
      @current_members = @project.team_members
    end

    @member_deleted_message  = session[:member_delete]
    session[:member_delete] = nil

    # @users = User.all
  end

  def new
    @user = User.all
    @team_member = TeamMember.new
    @team = Team.find_by(user_id: current_user)
    @project = Project.find_by_id(params[:project_id])
  end

  def create
    @team = Team.find_by(user_id: current_user)
    @project = Project.find_by_id(params[:project_id])
    @team_member= TeamMember.new(member_params)
    if @project.project_admin == true
      if @team_member.save
        @project.team_members << @team_member

        session[:member_success] = "Team member added!"
        redirect_to project_team_members_path(@project)
      end
    else
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
    @team = Team.find_by(user_id: current_user)
    @project = Project.find_by_id(params[:project_id])
    @team_member = TeamMember.find_by_id(params[:id])

    if @team_member.project_id == @project.id
      @team_member.delete
    end
    session[:member_delete] = "Member removed from #{@project.name}."
    redirect_to project_team_members_path(@project)
  end

  private

  def member_params
    params.require(:team_member).permit(:name, :email)
  end

end
