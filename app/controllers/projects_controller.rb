class ProjectsController < ApplicationController
  before_action :require_logged_in, only: [:new, :show, :edit, :update, :destroy]
    
  def index
    @teams = Team.all
    @user = current_user
  end

end
