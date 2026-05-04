class ContactMessage < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :unread, -> { where(status: "unread") }
  scope :recent, -> { order(created_at: :desc) }
end
