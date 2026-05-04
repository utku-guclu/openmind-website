class ApplicationsController < ApplicationController
  def new
    @application = VolunteerApplication.new
    @application.application_type = params[:type] if params[:type].present?
    @projects = Project.active.ordered
    @destinations = Destination.active.ordered
  end

  def create
    @application = VolunteerApplication.new(application_params)
    if @application.save
      redirect_to new_application_path, notice: "Thank you! Your application has been submitted. We'll be in touch soon."
    else
      @projects = Project.active.ordered
      @destinations = Destination.active.ordered
      render :new, status: :unprocessable_entity
    end
  end

  private

  def application_params
    params.require(:volunteer_application).permit(
      :first_name, :last_name, :email, :phone, :nationality,
      :date_of_birth, :application_type, :project_id, :destination_id,
      :preferred_start_date, :duration_weeks, :skills, :motivation, :experience
    )
  end
end
