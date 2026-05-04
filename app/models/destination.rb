class Destination < ApplicationRecord
  has_many :projects, dependent: :nullify
  has_many :volunteer_applications, dependent: :nullify

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :country_code, length: { is: 2 }, allow_blank: true

  scope :active, -> { where(status: "active") }
  scope :ordered, -> { order(position: :asc) }

  before_validation :generate_slug, if: -> { slug.blank? && name.present? }

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = name.parameterize
  end
end
