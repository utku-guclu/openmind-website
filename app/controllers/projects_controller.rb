class ProjectsController < ApplicationController
  def index
    @current_category = params[:category].presence
    @categories = Project.available_categories
    @category_counts = Project.active.group(:category).count
    @projects = Project.active.ordered
    @projects = @projects.by_category(@current_category) if @current_category
    @destinations = Destination.active.ordered
  end

  def show
    @project = Project.find_by!(slug: params[:slug])
    @related_projects = Project.active.where.not(id: @project.id).where(destination: @project.destination).limit(3)
  end
end
