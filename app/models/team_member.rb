class TeamMember < ApplicationRecord
  validates :name, presence: true
  validates :role, presence: true

  scope :active, -> { where(active: true) }
  scope :ordered, -> { order(position: :asc) }
end
