class CategoriesController < ApplicationController
  before_action :require_logged_in

  def index
    @filters = [["Category", "category"], ["Updated At", "updated_at", {:selected => "selected"}]]

    @categories = Category.all.order(:name)

    @projects = Project.all
    @users = User.all
  end

  def show
    @category = Category.find_by_id(@project.category_id)
  end

end
