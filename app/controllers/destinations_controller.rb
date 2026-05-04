class DestinationsController < ApplicationController
  def index
    @destinations = Destination.active.ordered
  end

  def show
    @destination = Destination.find_by!(slug: params[:slug])
    @projects = @destination.projects.active.ordered
  end
end
