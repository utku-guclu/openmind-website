class AdminUser < ApplicationRecord
  has_secure_password
  has_many :posts, foreign_key: :author_id, dependent: :nullify

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, inclusion: { in: %w[superadmin admin editor] }
end
