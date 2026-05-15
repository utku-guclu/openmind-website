class PagesController < ApplicationController
  def home
    @featured_projects = Project.active.ordered.limit(3)
    @partners = Partner.active.ordered
    @testimonials = Testimonial.featured.ordered.limit(6)
    @settings = SiteSetting.to_hash
  end

  def about
    @team_members = TeamMember.active.ordered
    @settings = SiteSetting.to_hash
  end

  def volunteer
    @projects = Project.active.ordered
    @destinations = Destination.active.ordered
    @testimonials = Testimonial.featured.ordered
    @audiences = VolunteerAudience.all
  end

  def volunteer_audience
    @audience = VolunteerAudience.find(params[:audience])
    raise ActionController::RoutingError, "Not Found" unless @audience
    @other_audiences = VolunteerAudience.all.reject { |a| a.slug == @audience.slug }
    @projects = Project.active.ordered.limit(3)
    render :volunteer_audience
  end

  def research
    @settings = SiteSetting.to_hash
  end

  def styleguide
    # Only available in development
    head :not_found and return unless Rails.env.development?
  end
end
