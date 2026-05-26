class VolunteerApplication < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :destination, optional: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :application_type, inclusion: { in: %w[volunteer_onsite volunteer_online internship] }, allow_blank: true

  scope :pending, -> { where(status: "pending") }
  scope :recent, -> { order(created_at: :desc) }

  def full_name
    "#{first_name} #{last_name}"
  end
end
