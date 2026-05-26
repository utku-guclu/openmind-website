class Project < ApplicationRecord
  CATEGORIES = {
    "english"      => { label: "English Teaching",  icon: "ph-chalkboard-teacher", color: "blue" },
    "it"           => { label: "IT & Programming",  icon: "ph-code",               color: "teal" },
    "camps"        => { label: "Learning Camps",    icon: "ph-tent",               color: "accent" },
    "ttt"          => { label: "Train the Trainer", icon: "ph-graduation-cap",     color: "green" },
    "voluntourism" => { label: "Voluntourism",      icon: "ph-compass",            color: "cornflower" },
    "construction" => { label: "Construction",      icon: "ph-hammer",             color: "accent" },
    "education"    => { label: "Education",         icon: "ph-book-open",          color: "blue" },
    "teaching"     => { label: "Teaching",          icon: "ph-chalkboard",         color: "blue" },
    "it_training"  => { label: "IT Training",       icon: "ph-code",               color: "teal" }
  }.freeze

  has_one_attached :image
  has_many_attached :gallery_images
  has_rich_text :content

  belongs_to :destination, optional: true
  belongs_to :location, optional: true
  has_many :testimonials, dependent: :nullify
  has_many :volunteer_applications, dependent: :nullify

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  store_accessor :meta,
    # Overview & Impact
    :project_highlights, :volunteer_role, :impact_statement,
    # Requirements
    :minimum_age, :maximum_age, :physical_fitness_level, :language_requirements, :required_skills,
    # Cost & Accommodation
    :cost_per_week, :currency, :whats_included, :whats_not_included,
    :accommodation_type, :meals_provided, :airport_transfer_included,
    # Schedule
    :start_dates, :daily_schedule, :working_hours_per_week, :free_time_activities,
    # Support & Safety
    :local_support, :safety_guidelines, :emergency_contact_info, :application_process,
    # Media & SEO
    :hero_video_url, :seo_title, :seo_meta_description, :seo_keywords

  scope :active, -> { where(status: "active") }
  scope :ordered, -> { order(position: :asc) }
  scope :by_category, ->(cat) { where(category: cat) if cat.present? }

  before_validation :generate_slug, if: -> { slug.blank? && title.present? }

  def to_param
    slug
  end

  def category_meta
    CATEGORIES[category] || { label: category.to_s.titleize, icon: "ph-tag", color: "blue" }
  end

  def category_label
    category_meta[:label]
  end

  def category_icon
    category_meta[:icon]
  end

  def category_color
    category_meta[:color]
  end

  def self.available_categories
    used = active.distinct.pluck(:category).compact
    CATEGORIES.select { |k, _| used.include?(k) }
  end

  private

  def generate_slug
    self.slug = title.parameterize
  end
end
