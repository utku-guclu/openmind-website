class AudienceActivityBullet < ApplicationRecord
  belongs_to :volunteer_audience

  validates :body, presence: true

  scope :ordered, -> { order(position: :asc) }
end
