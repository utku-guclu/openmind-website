class CreatePartners < ActiveRecord::Migration[8.1]
  def change
    create_table :partners do |t|
      t.string :name, null: false
      t.string :url
      t.string :tier, default: "standard"
      t.integer :position, default: 0
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
