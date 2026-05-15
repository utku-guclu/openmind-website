class CreateVolunteerAudiences < ActiveRecord::Migration[8.1]
  def change
    create_table :volunteer_audiences do |t|
      t.string  :slug,          null: false
      t.string  :name,          null: false
      t.string  :title
      t.text    :subtitle
      t.text    :intro
      t.string  :icon
      t.string  :hero_image
      t.string  :hero_video_id
      t.string  :duration
      t.string  :cta_text,      default: "Apply Today"
      t.string  :podcast_url
      t.jsonb   :content,       default: {}, null: false
      t.string  :status,        default: "active"
      t.integer :position,      default: 0

      t.timestamps
    end
    add_index :volunteer_audiences, :slug, unique: true
    add_index :volunteer_audiences, :status
    add_index :volunteer_audiences, :position
  end
end
