class AudienceGalleryImage < ApplicationRecord
  belongs_to :volunteer_audience
  has_one_attached :file

  scope :ordered, -> { order(position: :asc) }

  # Returns the uploaded attachment URL if a file is attached,
  # otherwise the fallback URL string. Returns nil if neither exists.
  def display_url
    if file.attached?
      Rails.application.routes.url_helpers.rails_blob_path(file, only_path: true)
    else
      image_url.presence
    end
  end
end
