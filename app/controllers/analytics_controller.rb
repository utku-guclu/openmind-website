class AnalyticsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :track
  before_action :verify_same_origin, only: :track

  rate_limit to: 120, within: 1.minute, only: :track, by: -> { request.remote_ip },
             with: -> { head :too_many_requests }

  # POST /analytics/track
  # JS beacon endpoint — receives page view and interaction events
  def track
    AnalyticsEvent.create!(
      recorded_at: Time.current,
      event_type: analytics_params[:event_type],
      page_path: analytics_params[:page_path],
      referrer: analytics_params[:referrer],
      country: request.headers["CF-IPCountry"],
      device_type: detect_device_type,
      session_id: analytics_params[:session_id],
      properties: analytics_params[:properties] || {}
    )

    head :no_content
  rescue ActiveRecord::RecordInvalid
    head :unprocessable_entity
  end

  private

  def analytics_params
    params.permit(:event_type, :page_path, :referrer, :session_id, properties: {})
  end

  def verify_same_origin
    return if Rails.env.development? || Rails.env.test?

    origin = request.headers["Origin"] || request.headers["Referer"]
    return if origin.blank?

    host = URI.parse(origin).host rescue nil
    head :forbidden unless host == request.host
  end

  def detect_device_type
    user_agent = request.user_agent.to_s.downcase
    if user_agent.match?(/mobile|android|iphone/)
      "mobile"
    elsif user_agent.match?(/tablet|ipad/)
      "tablet"
    else
      "desktop"
    end
  end
end
