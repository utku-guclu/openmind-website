class CreateContactMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :contact_messages do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :subject
      t.text :message
      t.string :status, default: "unread"

      t.timestamps
    end
    add_index :contact_messages, :status
  end
end
