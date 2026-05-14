class Project < ApplicationRecord
  has_one_attached :image
  has_rich_text :content

  belongs_to :destination, optional: true
  has_many :testimonials, dependent: :nullify
  has_many :volunteer_applications, dependent: :nullify

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :active, -> { where(status: "active") }
  scope :ordered, -> { order(position: :asc) }
  scope :by_category, ->(cat) { where(category: cat) if cat.present? }

  before_validation :generate_slug, if: -> { slug.blank? && title.present? }

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = title.parameterize
  end
end
