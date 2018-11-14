class CategoriesController < ApplicationController
  before_action :require_logged_in

  def index
    @topics = Topic.all.order(:name)
    @users = User.all
    @categories = Category.alphabetical_order
    # @category = Category.find_by_id(@post.category_id)

    @filters = [["Category", "category", {:selected => "selected"}]]
    # , ["Updated At", "updated_at", {:selected => "selected"}]]
    if params[:sort]
      c = Category.find(params[:sort][:filters]).posts.pluck(:id)
      if !c.empty?
        @topics = Topic.find(c)
      else
        @topics = Topic.alphabetical_order
      end
    else
      render :index
    end
  end

      # @categories = Category.send(params[:sort][:filters].parameterize.to_sym)

  def show
    @category = Category.find_by_id(@post.category_id)
  end

end
