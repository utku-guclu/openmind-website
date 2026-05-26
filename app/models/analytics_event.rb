# AnalyticsEvent lives in the TimescaleDB hypertable.
# It has no auto-incrementing id; the primary dimension is recorded_at.
class AnalyticsEvent < ApplicationRecord
  self.primary_key = :recorded_at

  validates :recorded_at, presence: true
  validates :event_type, presence: true

  scope :page_views, -> { where(event_type: "page_view") }
  scope :since, ->(time) { where("recorded_at >= ?", time) }
  scope :by_path, ->(path) { where(page_path: path) if path.present? }
end
