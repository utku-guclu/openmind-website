class DestinationsController < ApplicationController
  def index
    @destinations = Destination.visible.ordered
  end

  def show
    @destination = Destination.visible.find_by!(slug: params[:slug])
    @projects = @destination.projects.active.ordered
  end
end
