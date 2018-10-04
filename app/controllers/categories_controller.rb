class CategoriesController < ApplicationController
  before_action :require_logged_in

  def index
    @categories = Category.all.order(:name)

    @projects = Project.all
    @users = User.all
  end

  def show
    @category = Category.find_by_id(params[:id])
    @industry = @category.name
    @project = Project.find_by_id(params[:team_id])


  end

end
