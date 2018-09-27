class MembersController < ApplicationController
  before_action :require_logged_in
  before_action :authenticate_user, only: %i[new show destroy]


  def index
    @users = User.all
    @members = Member.all

    @team = Team.find_by_id(params[:team_id])
    if !!params[:team_id]
      @current_members = @team.members
    else
      redirect_to '/404'
    end

    @member_delete_message = session[:member_delete]
    session[:member_delete] = nil

    @admin_failure_message  = session[:admin_failure]
    session[:admin_failure] = nil
  end


  def new
    @members = Member.all
    @users = User.all

    @member = Member.new

    @team = Team.find_by_id(params[:team_id])
  end


  def create
    @team = Team.find_by_id(params[:team_id])
    @user = User.grab_teammate(member_params[:user_id])

    if @user.id == member_params[:user_id].to_i
      @member = Member.new(member_params)

      if @member.save
        @team.members << @member

        session[:member_success] = "Team member added!"
        redirect_to team_path(@team)
      else
        render :new
      end
    end
  end


  def show
    @team = Team.find_by_id(params[:team_id])
    @project = Project.find_by_id(params[:project_id])
    @member = Member.find_by_id(params[:id])

    @current_members = @team.members

    @member_deleted_message  = session[:member_delete]
    session[:member_delete] = nil
  end


  def destroy
   @team = Team.find_by_id(@project.team_id)
   @project = Project.find_by_id(params[:project_id])
    @member = Member.find_by_id(params[:id])

    if @member.team_id == @team.id
      @member.delete
    end
    session[:member_delete] = "Member has been removed."
    redirect_to team_members_path(@team.id)
  end



  private

  def member_params
    params.require(:member).permit(:user_id, :name, :email, :image, :time_zone)
  end

  def authenticate_user
    if logged_in?
      unless is_admin?
        session[:admin_error] = "You are not admin"
        redirect_to project_members_path(@project) # halts request cycle
      end
    end
  end

  def is_admin?
    @team = Team.find_by(user_id: current_user) if current_user
    @team.team_admin == true ? true : false
  end

end
