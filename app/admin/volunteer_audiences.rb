ActiveAdmin.register VolunteerAudience do
  menu label: "Volunteer Audiences", priority: 4

  permit_params :slug, :name, :title, :subtitle, :intro, :icon,
                :hero_image, :hero_image_url, :hero_video_id, :duration,
                :cta_text, :podcast_url, :status, :position,
                :activity_intro,
                :podcast_deepdive_title, :podcast_deepdive_description, :podcast_deepdive_image,
                benefits_attributes:           [:id, :icon, :title, :text, :position, :_destroy],
                journey_attributes:            [:id, :step_label, :title, :text, :position, :_destroy],
                intro_sections_attributes:     [:id, :heading, :body, :position, :_destroy],
                bond_sections_attributes:      [:id, :heading, :body, :position, :_destroy],
                activity_bullets_attributes:   [:id, :body, :position, :_destroy],
                videos_attributes:             [:id, :youtube_id, :title, :duration, :position, :_destroy],
                faqs_attributes:               [:id, :question, :answer, :position, :_destroy],
                gallery_images_attributes:     [:id, :file, :image_url, :alt, :position, :_destroy]

  controller do
    defaults finder: :find_by_slug!
  end

  filter :name
  filter :slug
  filter :status, as: :select, collection: %w[active inactive]

  index do
    selectable_column
    column :position
    column :name
    column :slug
    column :status
    column "Hero" do |a|
      if a.hero_image.attached?
        "📷 attached"
      elsif a.hero_image_url.present?
        "🔗 URL"
      end
    end
    column "Video?" do |a|
      "Yes" if a.hero_video_id.present?
    end
    column "Sections" do |a|
      [
        ("#{a.benefits.size} benefits"        if a.benefits.any?),
        ("#{a.journey.size} journey"          if a.journey.any?),
        ("#{a.intro_sections.size} intro"     if a.intro_sections.any?),
        ("#{a.bond_sections.size} bond"       if a.bond_sections.any?),
        ("#{a.gallery_images.size} gallery"   if a.gallery_images.any?),
        ("#{a.videos.size} videos"            if a.videos.any?),
        ("#{a.faqs.size} FAQs"                if a.faqs.any?),
        ("podcast"                            if a.podcast_url.present?)
      ].compact.join(" · ")
    end
    actions
  end

  show do
    attributes_table do
      row :slug
      row :name
      row :title
      row :subtitle
      row :intro
      row :icon
      row "Hero image" do |a|
        if a.hero_image.attached?
          image_tag url_for(a.hero_image), style: "max-width: 280px; border-radius: 8px;"
        elsif a.hero_image_url.present?
          link_to a.hero_image_url, a.hero_image_url, target: "_blank"
        end
      end
      row "Hero video (YouTube ID)" do |a|
        a.hero_video_id
      end
      row :duration
      row :cta_text
      row :status
      row :position
    end

    panel "Activity bullets" do
      attributes_table_for resource do
        row :activity_intro
      end
      table_for resource.activity_bullets do
        column :position
        column :body
      end
    end

    panel "Benefits"        do; table_for(resource.benefits)       { |t| t.column :position; t.column :icon; t.column :title; t.column :text }; end
    panel "Journey"         do; table_for(resource.journey)        { |t| t.column :position; t.column :step_label; t.column :title; t.column :text }; end
    panel "Intro sections"  do; table_for(resource.intro_sections) { |t| t.column :position; t.column :heading; t.column :body }; end
    panel "Bond sections"   do; table_for(resource.bond_sections)  { |t| t.column :position; t.column :heading; t.column :body }; end
    panel "Videos"          do; table_for(resource.videos)         { |t| t.column :position; t.column :youtube_id; t.column :title; t.column :duration }; end
    panel "FAQs"            do; table_for(resource.faqs)           { |t| t.column :position; t.column :question; t.column :answer }; end

    panel "Gallery" do
      div style: "display: grid; grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 12px;" do
        resource.gallery_images.each do |img|
          div do
            if img.file.attached?
              image_tag url_for(img.file), style: "width: 100%; height: 120px; object-fit: cover; border-radius: 6px;"
            elsif img.image_url.present?
              image_tag img.image_url, style: "width: 100%; height: 120px; object-fit: cover; border-radius: 6px;"
            end
            div style: "font-size: 11px; color: #666; margin-top: 4px;" do
              "#{img.position} — #{img.alt.presence || '(no alt)'}"
            end
          end
        end
      end
    end

    panel "Podcast deep-dive" do
      attributes_table_for resource do
        row :podcast_url
        row :podcast_deepdive_title
        row :podcast_deepdive_description
        row "Deep-dive image" do |a|
          if a.podcast_deepdive_image.attached?
            image_tag url_for(a.podcast_deepdive_image), style: "max-width: 280px; border-radius: 8px;"
          end
        end
      end
    end
  end

  form html: { multipart: true } do |f|
    f.inputs "Basic info" do
      f.input :slug, hint: "URL fragment, e.g. 'family' → /volunteer/family. Underscores convert to hyphens in URLs."
      f.input :name, hint: "Short label for navigation and tiles, e.g. 'Family'"
      f.input :title, hint: "Main heading rendered in the hero / intro section"
      f.input :subtitle, as: :text, input_html: { rows: 2 }
      f.input :intro, as: :text, input_html: { rows: 4 }
      f.input :icon, hint: "Phosphor icon name, e.g. 'ph-users-four'"
      f.input :duration, hint: "Free-text label like 'Flexible — 2 weeks to several months'"
      f.input :cta_text
    end

    f.inputs "Hero" do
      f.input :hero_image, as: :file,
              hint: f.object.hero_image.attached? ? image_tag(url_for(f.object.hero_image), style: "max-width: 200px; border-radius: 6px;") : "Upload an image — overrides the URL fallback below"
      f.input :hero_image_url, hint: "Optional URL fallback used when no file is attached"
      f.input :hero_video_id, hint: "YouTube ID for a video-background hero (optional). E.g. '1XgHBR_I6Yw'"
    end

    f.inputs "Visibility" do
      f.input :status, as: :select, collection: %w[active inactive], include_blank: false
      f.input :position
    end

    f.inputs "Benefits" do
      f.has_many :benefits, allow_destroy: true, new_record: "+ Add benefit", heading: false do |bf|
        bf.input :icon,  hint: "Phosphor icon, e.g. 'ph-heart'"
        bf.input :title
        bf.input :text, as: :text, input_html: { rows: 2 }
        bf.input :position
      end
    end

    f.inputs "Journey steps" do
      f.has_many :journey, allow_destroy: true, new_record: "+ Add step", heading: false do |jf|
        jf.input :step_label, hint: "Short label like '1', '2', or 'Day 1'"
        jf.input :title
        jf.input :text, as: :text, input_html: { rows: 2 }
        jf.input :position
      end
    end

    f.inputs "Intro sections (e.g. 'Make a Difference Together')" do
      f.has_many :intro_sections, allow_destroy: true, new_record: "+ Add intro section", heading: false do |sf|
        sf.input :heading
        sf.input :body, as: :text, input_html: { rows: 3 }
        sf.input :position
      end
    end

    f.inputs "Activity bullets" do
      f.input :activity_intro, as: :text, input_html: { rows: 2 },
              hint: "Heading shown above the bullet list"
      f.has_many :activity_bullets, allow_destroy: true, new_record: "+ Add bullet", heading: false do |bf|
        bf.input :body, as: :text, input_html: { rows: 2 }
        bf.input :position
      end
    end

    f.inputs "Bond / philosophy sections" do
      f.has_many :bond_sections, allow_destroy: true, new_record: "+ Add bond section", heading: false do |sf|
        sf.input :heading
        sf.input :body, as: :text, input_html: { rows: 4 }
        sf.input :position
      end
    end

    f.inputs "Gallery images" do
      f.has_many :gallery_images, allow_destroy: true, new_record: "+ Add image", heading: false do |gf|
        gf.input :file, as: :file,
                 hint: gf.object.file.attached? ? image_tag(url_for(gf.object.file), style: "max-width: 140px; border-radius: 4px;") : "Upload — overrides the URL fallback"
        gf.input :image_url, hint: "Optional URL fallback when no file is uploaded"
        gf.input :alt, hint: "Alt text for accessibility"
        gf.input :position
      end
    end

    f.inputs "Video playlist" do
      f.has_many :videos, allow_destroy: true, new_record: "+ Add video", heading: false do |vf|
        vf.input :youtube_id, hint: "YouTube video ID, e.g. 'W1yJxY52E28'"
        vf.input :title
        vf.input :duration, hint: "Human-readable length, e.g. '2:01'"
        vf.input :position
      end
    end

    f.inputs "Podcast" do
      f.input :podcast_url, hint: "SoundCloud track URL (optional)"
      f.input :podcast_deepdive_title
      f.input :podcast_deepdive_description, as: :text, input_html: { rows: 3 }
      f.input :podcast_deepdive_image, as: :file,
              hint: f.object.podcast_deepdive_image.attached? ? image_tag(url_for(f.object.podcast_deepdive_image), style: "max-width: 200px; border-radius: 6px;") : "Upload the deep-dive thumbnail"
    end

    f.inputs "FAQs" do
      f.has_many :faqs, allow_destroy: true, new_record: "+ Add FAQ", heading: false do |ff|
        ff.input :question
        ff.input :answer, as: :text, input_html: { rows: 4 }
        ff.input :position
      end
    end

    f.actions
  end
end
