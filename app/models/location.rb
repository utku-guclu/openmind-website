class Location < ApplicationRecord
  belongs_to :destination
  has_many :projects, dependent: :nullify

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :active, -> { where(status: "active") }
  scope :ordered, -> { order(position: :asc) }

  before_validation :generate_slug, if: -> { slug.blank? && name.present? }

  def to_param
    slug
  end

  private

  def generate_slug
    base = "#{destination&.slug}-#{name}".parameterize
    self.slug = base
  end
end
