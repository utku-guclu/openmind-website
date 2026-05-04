class CreateTeamMembers < ActiveRecord::Migration[8.1]
  def change
    create_table :team_members do |t|
      t.string :name, null: false
      t.string :role, null: false
      t.string :department
      t.text :bio
      t.string :linkedin_url
      t.string :github_url
      t.integer :position, default: 0
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
