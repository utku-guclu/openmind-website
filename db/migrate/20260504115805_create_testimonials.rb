class CreateTestimonials < ActiveRecord::Migration[8.1]
  def change
    create_table :testimonials do |t|
      t.string :name, null: false
      t.string :role
      t.text :quote
      t.string :video_url
      t.string :country
      t.references :project, foreign_key: true
      t.boolean :featured, default: false
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
