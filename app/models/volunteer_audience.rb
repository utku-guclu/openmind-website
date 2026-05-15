class VolunteerAudience < ApplicationRecord
  has_one_attached :hero_image
  has_one_attached :podcast_deepdive_image

  has_many :benefits,          -> { ordered }, class_name: "AudienceBenefit",        dependent: :destroy
  has_many :journey,           -> { ordered }, class_name: "AudienceJourneyStep",    dependent: :destroy
  has_many :intro_sections,    -> { ordered }, class_name: "AudienceIntroSection",   dependent: :destroy
  has_many :bond_sections,     -> { ordered }, class_name: "AudienceBondSection",    dependent: :destroy
  has_many :activity_bullets,  -> { ordered }, class_name: "AudienceActivityBullet", dependent: :destroy
  has_many :videos,            -> { ordered }, class_name: "AudienceVideo",          dependent: :destroy
  has_many :faqs,              -> { ordered }, class_name: "AudienceFaq",            dependent: :destroy
  has_many :gallery_images,    -> { ordered }, class_name: "AudienceGalleryImage",   dependent: :destroy

  accepts_nested_attributes_for :benefits, :journey, :intro_sections, :bond_sections,
                                :activity_bullets, :videos, :faqs, :gallery_images,
                                allow_destroy: true, reject_if: :all_blank

  validates :slug, presence: true, uniqueness: true
  validates :name, presence: true

  scope :active,  -> { where(status: "active") }
  scope :ordered, -> { order(position: :asc) }

  def to_param
    slug
  end

  # URL like /volunteer/gap-year (slug uses underscores in DB but hyphens in URL)
  def path
    "/volunteer/#{slug.to_s.tr('_', '-')}"
  end

  # Returns the hero image: uploaded attachment if present, otherwise the
  # fallback URL stored on `hero_image_url`.
  def hero_image_src
    if hero_image.attached?
      Rails.application.routes.url_helpers.url_for(hero_image)
    else
      hero_image_url.presence
    end
  end

  # Same fallback strategy for the podcast deep-dive thumbnail.
  def podcast_deepdive_image_src
    if podcast_deepdive_image.attached?
      Rails.application.routes.url_helpers.url_for(podcast_deepdive_image)
    else
      nil
    end
  end

  # The view organism wants a hash with title/image/description keys.
  # Built from the dedicated columns + attachment URL.
  def podcast_deepdive
    return nil unless podcast_deepdive_title.present? || podcast_deepdive_description.present?
    {
      title:       podcast_deepdive_title,
      description: podcast_deepdive_description,
      image:       podcast_deepdive_image_src
    }
  end
end
