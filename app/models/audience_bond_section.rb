class AudienceBondSection < ApplicationRecord
  belongs_to :volunteer_audience

  validates :heading, presence: true

  scope :ordered, -> { order(position: :asc) }
end
