class AdminUser < ApplicationRecord
  # Devise modules. The role column ("superadmin" / "admin" / "editor") still
  # drives authorization via CanCanCan; Devise only handles authentication.
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
         :validatable

  has_many :posts, foreign_key: :author_id, dependent: :nullify

  ROLES = %w[superadmin admin editor].freeze
  validates :role, inclusion: { in: ROLES }

  def superadmin? = role == "superadmin"
  def admin?      = %w[superadmin admin].include?(role)
  def editor?     = ROLES.include?(role)
end
