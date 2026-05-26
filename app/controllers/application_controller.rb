class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # CanCanCan raises this when an admin tries something their role doesn't
  # allow; ActiveAdmin then redirects back to the admin root with a flash.
  def access_denied(exception)
    redirect_to admin_root_path, alert: exception.message
  end
end
