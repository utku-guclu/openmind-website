class ProjectsController < ApplicationController
  def index
    @projects = Project.active.ordered
    @projects = @projects.by_category(params[:category]) if params[:category].present?
    @destinations = Destination.active.ordered
  end

  def show
    @project = Project.find_by!(slug: params[:slug])
    @related_projects = Project.active.where.not(id: @project.id).where(destination: @project.destination).limit(3)
  end
end
