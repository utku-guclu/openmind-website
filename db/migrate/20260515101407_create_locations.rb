class CreateLocations < ActiveRecord::Migration[8.1]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :region
      t.text :summary
      t.references :destination, null: false, foreign_key: true
      t.string :status, default: "active"
      t.integer :position, default: 0
      t.decimal :latitude, precision: 10, scale: 7
      t.decimal :longitude, precision: 10, scale: 7

      t.timestamps
    end
    add_index :locations, :slug, unique: true
    add_index :locations, :status
  end
end
