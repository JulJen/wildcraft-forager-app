class LocationsController < ApplicationController
  before_action :require_logged_in

  def index
    @topics = Topic.all.order(:name)
    @users = User.all
    @categories = Location.alphabetical_order
    # @location = Location.find_by_id(@topic.location_id)

    @filters = [["Location", "location", {:selected => "selected"}]]
    # , ["Updated At", "updated_at", {:selected => "selected"}]]
    if params[:sort]
      c = Location.find(params[:sort][:filters]).topics.pluck(:id)
      if !c.empty?
        @topics = Topic.find(c)
      else
        @topics = Topic.alphabetical_order
      end
    else
      render :index
    end
  end

      # @categories = Location.send(params[:sort][:filters].parameterize.to_sym)

  def show
    @location = Location.find_by_id(@topic.location_id)
  end

end
