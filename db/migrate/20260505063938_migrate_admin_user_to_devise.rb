class MigrateAdminUserToDevise < ActiveRecord::Migration[8.1]
  def up
    change_table :admin_users do |t|
      # Devise's database_authenticatable column. Renaming the existing
      # `password_digest` carries any existing bcrypt hashes over since Devise
      # and has_secure_password both use bcrypt with the same format.
      t.rename :password_digest, :encrypted_password

      # Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      # Rememberable
      t.datetime :remember_created_at

      # Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
    end

    change_column_default :admin_users, :encrypted_password, ""
    add_index :admin_users, :reset_password_token, unique: true
  end

  def down
    remove_index :admin_users, :reset_password_token
    change_table :admin_users do |t|
      t.remove :reset_password_token, :reset_password_sent_at,
               :remember_created_at,
               :sign_in_count, :current_sign_in_at, :last_sign_in_at,
               :current_sign_in_ip, :last_sign_in_ip
      t.rename :encrypted_password, :password_digest
    end
  end
end
