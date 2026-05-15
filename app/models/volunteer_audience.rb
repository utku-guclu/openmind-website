class VolunteerAudience < ApplicationRecord
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

  # Content JSON readers — return symbol-keyed hashes so existing views
  # (which use b[:icon], s[:heading], etc.) keep working unchanged.

  def benefits;         fetch_list_of_hashes("benefits");       end
  def journey;          fetch_list_of_hashes("journey");        end
  def intro_sections;   fetch_list_of_hashes("intro_sections"); end
  def bond_sections;    fetch_list_of_hashes("bond_sections");  end
  def video_playlist;   fetch_list_of_hashes("video_playlist"); end
  def faqs;             fetch_list_of_hashes("faqs");           end

  def gallery_images;   Array(content&.dig("gallery_images")); end
  def activity_bullets; Array(content&.dig("activity_bullets")); end
  def activity_intro;   content&.dig("activity_intro"); end

  def podcast_deepdive
    h = content&.dig("podcast_deepdive")
    h.is_a?(Hash) ? h.deep_symbolize_keys : nil
  end

  private

  def fetch_list_of_hashes(key)
    Array(content&.dig(key)).map { |row| row.is_a?(Hash) ? row.deep_symbolize_keys : row }
  end
end
