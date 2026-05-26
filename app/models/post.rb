class Post < ApplicationRecord
  belongs_to :author, class_name: "AdminUser", optional: true

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :published, -> { where(status: "published").where("published_at <= ?", Time.current) }
  scope :recent, -> { order(published_at: :desc) }

  before_validation :generate_slug, if: -> { slug.blank? && title.present? }

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = title.parameterize
  end
end
