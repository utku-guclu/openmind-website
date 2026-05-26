class Testimonial < ApplicationRecord
  belongs_to :project, optional: true

  validates :name, presence: true

  scope :featured, -> { where(featured: true) }
  scope :ordered, -> { order(position: :asc) }
end
