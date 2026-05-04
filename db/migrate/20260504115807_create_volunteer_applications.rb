class CreateVolunteerApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :volunteer_applications do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone
      t.string :nationality
      t.date :date_of_birth
      t.string :application_type
      t.references :project, foreign_key: true
      t.references :destination, foreign_key: true
      t.date :preferred_start_date
      t.integer :duration_weeks
      t.text :skills
      t.text :motivation
      t.text :experience
      t.string :status, default: "pending"
      t.text :admin_notes
      t.jsonb :meta, default: {}

      t.timestamps
    end
    add_index :volunteer_applications, :status
    add_index :volunteer_applications, :email
    add_index :volunteer_applications, :application_type
  end
end
