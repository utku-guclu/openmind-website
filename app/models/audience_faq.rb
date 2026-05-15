class AudienceFaq < ApplicationRecord
  belongs_to :volunteer_audience

  validates :question, presence: true

  scope :ordered, -> { order(position: :asc) }
end
