class AnalyticsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :track

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
