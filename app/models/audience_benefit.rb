class AudienceBenefit < ApplicationRecord
  belongs_to :volunteer_audience

  validates :title, presence: true

  scope :ordered, -> { order(position: :asc) }
end
