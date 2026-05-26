ActiveAdmin.register Project do
  menu parent: "Programs", priority: 1
  permit_params :title, :slug, :summary, :description, :status, :category,
                :destination_id, :location_id, :location_name, :duration_weeks_min,
                :duration_weeks_max, :cover_image_alt, :position, :image, :content,
                :project_highlights, :volunteer_role, :impact_statement,
                :minimum_age, :maximum_age, :physical_fitness_level, :language_requirements, :required_skills,
                :cost_per_week, :currency, :whats_included, :whats_not_included,
                :accommodation_type, :meals_provided, :airport_transfer_included,
                :start_dates, :daily_schedule, :working_hours_per_week, :free_time_activities,
                :local_support, :safety_guidelines, :emergency_contact_info, :application_process,
                :hero_video_url, :seo_title, :seo_meta_description, :seo_keywords,
                gallery_images: []

  controller do
    defaults finder: :find_by_slug!
  end

  filter :title
  filter :status, as: :select, collection: %w[draft active archived]
  filter :category, as: :select, collection: Project::CATEGORIES.map { |k, m| [m[:label], k] }
  filter :destination

  index do
    selectable_column
    column :position, sortable: :position
    column "Cover" do |p|
      if p.image.attached?
        image_tag rails_blob_path(p.image, only_path: true), style: "width:60px; height:40px; object-fit:cover; border-radius:6px;"
      else
        div style: "width:60px; height:40px; background:#F0F4F8; border-radius:6px; display:flex; align-items:center; justify-content:center; color:#94a3b8; font-size:12px;" do
          "—"
        end
      end
    end
    column :title, sortable: :title
    column "Category" do |p|
      if p.category.present?
        status_tag p.category_label
      end
    end
    column "Location" do |p|
      if p.destination
        span { p.destination.name }
        if p.location
          span style: "color:#5D6D7E; font-size:.8rem;" do
            " · #{p.location.name}"
          end
        end
      end
    end
    column "Gallery" do |p|
      cnt = p.gallery_images.count
      cnt > 0 ? "#{cnt} images" : "—"
    end
    column("Status") { |p| status_tag p.status }
    actions
  end

  show do
    tabs do
      tab "Basic Info" do
        attributes_table do
          row :title
          row :slug
          row :status
          row :category do |p|
            p.category_label if p.category.present?
          end
          row :position
        end
      end

      tab "Location & Logistics" do
        attributes_table do
          row :destination
          row :location
          row :location_name
          row :duration_weeks_min
          row :duration_weeks_max
        end
      end

      tab "Content & Media" do
        attributes_table do
          row "Cover Image" do |p|
            if p.image.attached?
              image_tag rails_blob_path(p.image, only_path: true), style: "max-width: 300px; border-radius: 8px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);"
            end
          end
          row "Gallery" do |p|
            if p.gallery_images.attached?
              div style: "display: grid; grid-template-columns: repeat(auto-fill, minmax(180px, 1fr)); gap: 16px; padding: 8px 0;" do
                p.gallery_images.each do |img|
                  div style: "border-radius: 8px; overflow: hidden; border: 1px solid #e2e8f0;" do
                    image_tag rails_blob_path(img, only_path: true), style: "width: 100%; height: 140px; object-fit: cover; display: block;"
                  end
                end
              end
            else
              span class: "empty" do
                "No gallery images attached"
              end
            end
          end
          row :summary
          row :description
          row :content do |p|
            div class: "trix-content" do
              p.content.to_s.html_safe if p.content.present?
            end
          end
        end
      end

      tab "Project Details (Meta)" do
        attributes_table title: "Overview & Impact" do
          row :project_highlights
          row :volunteer_role
          row :impact_statement
        end
        attributes_table title: "Requirements" do
          row :minimum_age
          row :maximum_age
          row :physical_fitness_level
          row :language_requirements
          row :required_skills
        end
        attributes_table title: "Cost & Accommodation" do
          row :cost_per_week
          row :currency
          row :whats_included
          row :whats_not_included
          row :accommodation_type
          row :meals_provided
          row :airport_transfer_included
        end
        attributes_table title: "Schedule" do
          row :start_dates
          row :daily_schedule
          row :working_hours_per_week
          row :free_time_activities
        end
        attributes_table title: "Support & Safety" do
          row :local_support
          row :safety_guidelines
          row :emergency_contact_info
          row :application_process
        end
        attributes_table title: "Media & SEO" do
          row :hero_video_url
          row :seo_title
          row :seo_meta_description
          row :seo_keywords
        end
      end
    end
  end

  form html: { multipart: true } do |f|
    tabs do
      tab "Basic Info" do
        f.inputs "Basic info" do
          f.input :title
          f.input :slug, hint: "Auto-generated from the title if left blank. Underscores convert to hyphens."
          f.input :status, as: :select, collection: %w[draft active archived], include_blank: false
          f.input :category, as: :select, collection: Project::CATEGORIES.map { |k, m| [m[:label], k] }, include_blank: "— Select a category —"
          f.input :position, hint: "Used for manual sorting."
        end
      end

      tab "Location & Logistics" do
        f.inputs "Location Details" do
          f.input :destination
          f.input :location, as: :select, collection: Location.includes(:destination).active.order("destinations.position ASC, locations.position ASC").map { |l| ["#{l.destination.name} — #{l.name}", l.id] }, include_blank: "— Select a specific location —"
          f.input :location_name, label: "Legacy location name", hint: "Free-text fallback if no structured location is selected."
          f.input :duration_weeks_min, label: "Minimum duration (weeks)"
          f.input :duration_weeks_max, label: "Maximum duration (weeks)"
        end
      end

      tab "Content & Media" do
        f.inputs "Content" do
          f.input :image, as: :file, hint: f.object.image.attached? ? "Current: #{f.object.image.filename}" : "Upload a cover image."
          f.input :summary, input_html: { rows: 3 }, hint: "Short summary displayed on project cards."
          f.input :description, as: :text, input_html: { rows: 5 }, hint: "Detailed description of the project."
          f.input :content, as: :text, input_html: { rows: 12 },
                  hint: "HTML allowed. WYSIWYG editor is deferred — paste HTML or write plain text."
        end
        f.inputs "Gallery" do
          f.input :gallery_images, as: :file, input_html: { multiple: true }, hint: "Upload multiple images at once to create a gallery."
          if f.object.gallery_images.attached?
            li class: "input" do
              label "Current Gallery Images"
              div style: "display: grid; grid-template-columns: repeat(auto-fill, minmax(120px, 1fr)); gap: 10px; margin-left: 20%;" do
                f.object.gallery_images.each do |img|
                  div style: "border-radius: 4px; overflow: hidden; border: 1px solid #e2e8f0;" do
                    image_tag rails_blob_path(img, only_path: true), style: "width: 100%; height: 100px; object-fit: cover; display: block;"
                  end
                end
              end
            end
          end
        end
      end

      tab "Project Details (Meta)" do
        f.inputs "Overview & Impact" do
          f.input :project_highlights, as: :text, input_html: { rows: 3 }
          f.input :volunteer_role, as: :text, input_html: { rows: 3 }
          f.input :impact_statement, as: :text, input_html: { rows: 3 }
        end
        f.inputs "Requirements" do
          f.input :minimum_age
          f.input :maximum_age
          f.input :physical_fitness_level, as: :select, collection: ["Low", "Medium", "High"]
          f.input :language_requirements
          f.input :required_skills, as: :text, input_html: { rows: 3 }
        end
        f.inputs "Cost & Accommodation" do
          f.input :cost_per_week
          f.input :currency, as: :select, collection: ["USD", "EUR", "GBP", "THB"]
          f.input :whats_included, as: :text, input_html: { rows: 3 }
          f.input :whats_not_included, as: :text, input_html: { rows: 3 }
          f.input :accommodation_type
          f.input :meals_provided
          f.input :airport_transfer_included, as: :boolean
        end
        f.inputs "Schedule" do
          f.input :start_dates, as: :text, input_html: { rows: 2 }
          f.input :daily_schedule, as: :text, input_html: { rows: 3 }
          f.input :working_hours_per_week
          f.input :free_time_activities, as: :text, input_html: { rows: 3 }
        end
        f.inputs "Support & Safety" do
          f.input :local_support, as: :text, input_html: { rows: 3 }
          f.input :safety_guidelines, as: :text, input_html: { rows: 3 }
          f.input :emergency_contact_info, as: :text, input_html: { rows: 3 }
          f.input :application_process, as: :text, input_html: { rows: 3 }
        end
        f.inputs "Media & SEO" do
          f.input :hero_video_url
          f.input :seo_title
          f.input :seo_meta_description, as: :text, input_html: { rows: 2 }
          f.input :seo_keywords
        end
      end
    end
    f.actions
  end
end
