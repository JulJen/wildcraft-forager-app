class TeamMembersController < ApplicationController
  before_action :require_logged_in
  before_action :authenticate_user, only: %i[new show destroy]


  def index
    @users = User.all
    @team_members = TeamMember.all

    @team = Team.find_by(user_id: current_user)
    if !!params[:project_id]
      @project = Project.find_by_id(params[:project_id])
      @current_members = @project.team_members
    else
      redirect_to '/404'
    end

    @member_success_message = session[:member_success]
    session[:member_success] = nil

    @member_delete_message = session[:member_delete]
    session[:member_delete] = nil

    @admin_failure_message  = session[:admin_failure]
    session[:admin_failure] = nil
  end


  def new
    @team_members = TeamMember.all
    @users = User.all

    @team_member = TeamMember.new

    @team = Team.find_by(user_id: current_user)
    @project = Project.find_by_id(params[:project_id])
  end


  def create
    @project = Project.find_by_id(params[:project_id])
    @team = Team.find_by(user_id: current_user)
    @user = User.grab_teammate(member_params[:user_id])

    if @user.id == member_params[:user_id].to_i
      @team_member = TeamMember.new(member_params)

      if @team_member.save
        @project.team_members << @team_member

        session[:member_success] = "Team member added!"

        redirect_to project_team_members_path(@project)
      else
        render :new
      end
    else
      session[:admin_failure] = "Failure to invite members, contact the project admin."
      redirect_to project_team_members_path(@project)
    end
  end


  def show
    @team = Team.find_by(user_id: current_user)
    @project = Project.find_by_id(params[:project_id])
    @team_member = TeamMember.find_by_id(params[:id])

    @current_members = @project.team_members

    @member_deleted_message  = session[:member_delete]
    session[:member_delete] = nil
  end


  def destroy
    @team = Team.find_by(user_id: current_user)
    @project = Project.find_by_id(params[:project_id])
    @team_member = TeamMember.find_by_id(params[:id])

    if @team_member.project_id == @project.id
      @team_member.delete
    end
    session[:member_delete] = "Member has been removed."
    redirect_to project_team_members_path(@project.id)
  end



  private

  def member_params
    params.require(:team_member).permit(:user_id, :name, :email, :image, :time_zone)
  end

  def authenticate_user
    if logged_in?
      unless is_admin?
        session[:admin_error] = "You are not admin"
        redirect_to project_team_members_path(@project) # halts request cycle
      end
    end
  end

  def is_admin?
    @team = Team.find_by(user_id: current_user) if current_user
    @team.team_admin == true ? true : false
  end

end
