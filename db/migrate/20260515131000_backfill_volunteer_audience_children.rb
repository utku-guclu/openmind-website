class BackfillVolunteerAudienceChildren < ActiveRecord::Migration[8.1]
  # Run inside the migration so DDL + DML stay atomic per audience.
  # No-op if there's nothing to migrate (re-runnable safety).

  disable_ddl_transaction!

  def up
    VolunteerAudience.reset_column_information

    VolunteerAudience.find_each do |audience|
      content = audience.content
      next if content.blank?

      ActiveRecord::Base.transaction do
        # Top-level "scalar" content fields → audience columns
        if (intro = content["activity_intro"]).present? && audience.activity_intro.blank?
          audience.update_column(:activity_intro, intro)
        end

        deepdive = content["podcast_deepdive"]
        if deepdive.is_a?(Hash)
          audience.update_columns(
            podcast_deepdive_title:       deepdive["title"],
            podcast_deepdive_description: deepdive["description"]
          )
          # The deepdive image URL is preserved on the JSON but not yet attached.
          # We don't auto-download remote files into ActiveStorage — admins can
          # re-upload through the new admin UI when ready.
        end

        # List-shaped content → child tables
        Array(content["benefits"]).each_with_index do |b, i|
          next if audience.benefits.exists?(position: i)
          audience.benefits.create!(
            icon:     b["icon"],
            title:    b["title"],
            text:     b["text"],
            position: i
          )
        end

        Array(content["journey"]).each_with_index do |s, i|
          next if audience.journey.exists?(position: i)
          audience.journey.create!(
            step_label: s["step"],
            title:      s["title"],
            text:       s["text"],
            position:   i
          )
        end

        Array(content["intro_sections"]).each_with_index do |s, i|
          next if audience.intro_sections.exists?(position: i)
          audience.intro_sections.create!(
            heading:  s["heading"],
            body:     s["body"],
            position: i
          )
        end

        Array(content["bond_sections"]).each_with_index do |s, i|
          next if audience.bond_sections.exists?(position: i)
          audience.bond_sections.create!(
            heading:  s["heading"],
            body:     s["body"],
            position: i
          )
        end

        Array(content["activity_bullets"]).each_with_index do |body, i|
          next if audience.activity_bullets.exists?(position: i)
          audience.activity_bullets.create!(body: body, position: i)
        end

        Array(content["video_playlist"]).each_with_index do |v, i|
          next if audience.videos.exists?(position: i)
          audience.videos.create!(
            title:      v["title"],
            youtube_id: v["youtube_id"],
            duration:   v["duration"],
            position:   i
          )
        end

        Array(content["faqs"]).each_with_index do |f, i|
          next if audience.faqs.exists?(position: i)
          audience.faqs.create!(
            question: f["question"],
            answer:   f["answer"],
            position: i
          )
        end

        Array(content["gallery_images"]).each_with_index do |url, i|
          next if audience.gallery_images.exists?(position: i)
          audience.gallery_images.create!(
            image_url: url,
            position:  i
          )
        end
      end

      say "Backfilled audience: #{audience.slug}"
    end
  end

  def down
    # Truncate the child tables. The parent rows + content JSON are preserved
    # so a re-up restores everything.
    %i[audience_benefits audience_journey_steps audience_intro_sections
       audience_bond_sections audience_activity_bullets audience_videos
       audience_faqs audience_gallery_images].each do |table|
      execute "DELETE FROM #{table}"
    end
    execute "UPDATE volunteer_audiences SET activity_intro = NULL, podcast_deepdive_title = NULL, podcast_deepdive_description = NULL"
  end
end
