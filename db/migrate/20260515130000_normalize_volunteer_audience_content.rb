class NormalizeVolunteerAudienceContent < ActiveRecord::Migration[8.1]
  def change
    # Parent table: rename existing hero_image (a URL) and add fields that
    # were previously stored inside the content JSON column.
    rename_column :volunteer_audiences, :hero_image, :hero_image_url
    add_column :volunteer_audiences, :activity_intro,               :text
    add_column :volunteer_audiences, :podcast_deepdive_title,       :string
    add_column :volunteer_audiences, :podcast_deepdive_description, :text

    # Child tables — each row represents one item in what used to be a JSON array.

    create_table :audience_benefits do |t|
      t.references :volunteer_audience, null: false, foreign_key: true
      t.string  :icon
      t.string  :title
      t.text    :text
      t.integer :position, default: 0, null: false
      t.timestamps
    end
    add_index :audience_benefits, [:volunteer_audience_id, :position]

    create_table :audience_journey_steps do |t|
      t.references :volunteer_audience, null: false, foreign_key: true
      t.string  :step_label
      t.string  :title
      t.text    :text
      t.integer :position, default: 0, null: false
      t.timestamps
    end
    add_index :audience_journey_steps, [:volunteer_audience_id, :position]

    create_table :audience_intro_sections do |t|
      t.references :volunteer_audience, null: false, foreign_key: true
      t.string  :heading
      t.text    :body
      t.integer :position, default: 0, null: false
      t.timestamps
    end
    add_index :audience_intro_sections, [:volunteer_audience_id, :position]

    create_table :audience_bond_sections do |t|
      t.references :volunteer_audience, null: false, foreign_key: true
      t.string  :heading
      t.text    :body
      t.integer :position, default: 0, null: false
      t.timestamps
    end
    add_index :audience_bond_sections, [:volunteer_audience_id, :position]

    create_table :audience_activity_bullets do |t|
      t.references :volunteer_audience, null: false, foreign_key: true
      t.text    :body
      t.integer :position, default: 0, null: false
      t.timestamps
    end
    add_index :audience_activity_bullets, [:volunteer_audience_id, :position]

    create_table :audience_videos do |t|
      t.references :volunteer_audience, null: false, foreign_key: true
      t.string  :title
      t.string  :youtube_id, null: false
      t.string  :duration
      t.integer :position, default: 0, null: false
      t.timestamps
    end
    add_index :audience_videos, [:volunteer_audience_id, :position]

    create_table :audience_faqs do |t|
      t.references :volunteer_audience, null: false, foreign_key: true
      t.string  :question, null: false
      t.text    :answer
      t.integer :position, default: 0, null: false
      t.timestamps
    end
    add_index :audience_faqs, [:volunteer_audience_id, :position]

    create_table :audience_gallery_images do |t|
      t.references :volunteer_audience, null: false, foreign_key: true
      t.string  :image_url, comment: "Fallback URL when no file is attached"
      t.string  :alt
      t.integer :position, default: 0, null: false
      t.timestamps
    end
    add_index :audience_gallery_images, [:volunteer_audience_id, :position]
  end
end
