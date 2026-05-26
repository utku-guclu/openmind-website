class Partner < ApplicationRecord
  validates :name, presence: true

  scope :active, -> { where(active: true) }
  scope :featured, -> { where(tier: "featured") }
  scope :ordered, -> { order(position: :asc) }
end
