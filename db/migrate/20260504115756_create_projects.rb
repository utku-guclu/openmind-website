class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :summary
      t.text :description
      t.string :category
      t.string :status, default: "active"
      t.string :location_name
      t.references :destination, foreign_key: true
      t.integer :duration_weeks_min
      t.integer :duration_weeks_max
      t.string :cover_image_alt
      t.integer :position, default: 0
      t.jsonb :meta, default: {}

      t.timestamps
    end
    add_index :projects, :slug, unique: true
    add_index :projects, :status
    add_index :projects, :category
  end
end
