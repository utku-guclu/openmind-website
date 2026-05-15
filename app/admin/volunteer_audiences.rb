ActiveAdmin.register VolunteerAudience do
  menu label: "Volunteer Audiences", priority: 4

  permit_params :slug, :name, :title, :subtitle, :intro, :icon,
                :hero_image, :hero_video_id, :duration, :cta_text,
                :podcast_url, :status, :position, :content

  controller do
    defaults finder: :find_by_slug!

    # Allow admins to paste/edit JSON for the content column via a textarea.
    # Convert the submitted string back to a Hash before assignment.
    before_action :coerce_content_json, only: [:create, :update]

    def coerce_content_json
      return unless params.dig(:volunteer_audience, :content).is_a?(String)
      raw = params[:volunteer_audience][:content]
      params[:volunteer_audience][:content] = raw.blank? ? {} : JSON.parse(raw)
    rescue JSON::ParserError => e
      flash.now[:error] = "Invalid JSON in content field: #{e.message}"
      params[:volunteer_audience][:content] = resource.content
    end
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
    column "Video?" do |a|
      "Yes" if a.hero_video_id.present?
    end
    column "Sections" do |a|
      [
        ("benefits"        if a.benefits.any?),
        ("journey"         if a.journey.any?),
        ("intro_sections"  if a.intro_sections.any?),
        ("bond_sections"   if a.bond_sections.any?),
        ("gallery"         if a.gallery_images.any?),
        ("playlist"        if a.video_playlist.any?),
        ("podcast"         if a.podcast_url.present?),
        ("faqs"            if a.faqs.any?)
      ].compact.join(", ")
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
      row :hero_image
      row "Hero video (YouTube ID)" do |a|
        a.hero_video_id
      end
      row :duration
      row :cta_text
      row :podcast_url
      row :status
      row :position
      row "Content (JSON)" do |a|
        pre JSON.pretty_generate(a.content || {})
      end
    end
  end

  form do |f|
    f.inputs "Basic info" do
      f.input :slug, hint: "URL fragment, e.g. 'family' becomes /volunteer/family. Use underscores; they convert to hyphens in the URL."
      f.input :name, hint: "Short label shown in navigation and tiles, e.g. 'Family'"
      f.input :title, hint: "Main heading rendered in the hero / divider section"
      f.input :subtitle, as: :text, input_html: { rows: 2 }
      f.input :intro, as: :text, input_html: { rows: 4 }, hint: "Lead paragraph shown directly under the title"
      f.input :icon, hint: "Phosphor icon name, e.g. 'ph-users-four'"
      f.input :duration, hint: "Free-text duration label, e.g. 'Flexible — 2 weeks to several months'"
      f.input :cta_text
    end

    f.inputs "Media" do
      f.input :hero_image, hint: "Full URL to the hero image"
      f.input :hero_video_id, hint: "YouTube video ID for a background video hero (optional). E.g. '1XgHBR_I6Yw'"
      f.input :podcast_url, hint: "SoundCloud track URL (optional)"
    end

    f.inputs "Visibility" do
      f.input :status, as: :select, collection: %w[active inactive], include_blank: false
      f.input :position
    end

    f.inputs "Content (JSON)" do
      f.input :content,
              as: :text,
              input_html: {
                rows: 30,
                value: JSON.pretty_generate(f.object.content || {}),
                style: "font-family: monospace; font-size: 12px;"
              },
              hint: "JSON for nested sections: benefits, journey, intro_sections, bond_sections, gallery_images, video_playlist, faqs, activity_intro, activity_bullets, podcast_deepdive."
    end

    f.actions
  end
end
