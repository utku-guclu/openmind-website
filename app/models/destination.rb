class Destination < ApplicationRecord
  has_one_attached :hero_image

  has_many :projects, dependent: :nullify
  has_many :volunteer_applications, dependent: :nullify
  has_many :locations, -> { ordered }, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :country_code, length: { is: 2 }, allow_blank: true

  scope :active, -> { where(status: "active") }
  scope :visible, -> { where(status: %w[active coming_soon]) }
  scope :ordered, -> { order(position: :asc) }

  before_validation :generate_slug, if: -> { slug.blank? && name.present? }

  def to_param
    slug
  end

  def coming_soon?
    status == "coming_soon"
  end

  def activities
    Array(meta&.dig("activities"))
  end

  def activities=(value)
    self.meta = (meta || {}).merge("activities" => Array(value))
  end

  def location_names
    locations.active.ordered.pluck(:name)
  end

  def flag_emoji
    case country_code&.upcase
    when "TH" then "🇹🇭"
    when "LA" then "🇱🇦"
    when "NP" then "🇳🇵"
    when "KH" then "🇰🇭"
    when "VN" then "🇻🇳"
    when "MM" then "🇲🇲"
    end
  end

  # Returns the hero image: uploaded attachment if present, otherwise the
  # fallback URL stored on `hero_image_url`.
  def hero_image_src
    if hero_image.attached?
      Rails.application.routes.url_helpers.rails_blob_path(hero_image, only_path: true)
    else
      hero_image_url.presence
    end
  end

  private

  def generate_slug
    self.slug = name.parameterize
  end
end
