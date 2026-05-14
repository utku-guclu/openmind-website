ActiveAdmin.register SiteSetting do
  permit_params :key, :value, :value_type, :file, :content

  filter :key
  filter :value_type, as: :select, collection: %w[string integer boolean json]

  index do
    selectable_column
    column :key
    column :value_type
    column "Has Rich Text?" do |setting|
      setting.content.present? ? status_tag("Yes", class: "yes") : status_tag("No", class: "no")
    end
    column "Has File?" do |setting|
      setting.file.attached? ? status_tag("Yes", class: "yes") : status_tag("No", class: "no")
    end
    actions
  end

  form do |f|
    f.inputs "Site Setting (WordPress-style Content Editor)" do
      f.input :key, hint: "Unique identifier (snake_case). Read in views via SiteSetting.get(key)."
      f.input :value_type, as: :select, collection: %w[string integer boolean json]
      f.input :value, as: :string, hint: "For simple text, numbers, or boolean values."
      
      li class: "input" do
        f.label :content, "Rich Text Content (Styles, Links, etc)"
        div style: "display: inline-block; width: 78%;" do
          f.rich_text_area :content
        end
      end

      f.input :file, as: :file, hint: "Upload an image or video to override outsourced media."
    end
    f.actions
  end

  show do
    attributes_table do
      row :key
      row :value_type
      row :value
      row "Rich Text Content" do |s|
        s.content if s.content.present?
      end
      row "Attached File" do |s|
        if s.file.attached?
          if s.file.content_type.start_with?('image/')
            image_tag url_for(s.file), style: "max-width: 400px; height: auto;"
          elsif s.file.content_type.start_with?('video/')
            video_tag url_for(s.file), style: "max-width: 400px; height: auto;", controls: true
          else
            link_to s.file.filename, url_for(s.file)
          end
        else
          "No file attached"
        end
      end
    end
  end
end
