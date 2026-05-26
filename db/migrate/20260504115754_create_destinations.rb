class CreateDestinations < ActiveRecord::Migration[8.1]
  def change
    create_table :destinations do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :summary
      t.text :description
      t.string :country_code, limit: 2
      t.decimal :latitude, precision: 10, scale: 7
      t.decimal :longitude, precision: 10, scale: 7
      t.string :status, default: "active"
      t.integer :position, default: 0
      t.jsonb :meta, default: {}

      t.timestamps
    end
    add_index :destinations, :slug, unique: true
    add_index :destinations, :status
  end
end
