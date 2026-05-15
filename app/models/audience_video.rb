class AudienceVideo < ApplicationRecord
  belongs_to :volunteer_audience

  validates :youtube_id, presence: true

  scope :ordered, -> { order(position: :asc) }
end
