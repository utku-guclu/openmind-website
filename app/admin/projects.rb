ActiveAdmin.register Project do
  permit_params :title, :slug, :summary, :description, :status, :category,
                :destination_id, :location_name, :duration_weeks_min,
                :duration_weeks_max, :cover_image_alt, :position, :image, :content

  controller do
    defaults finder: :find_by_slug!
  end

  filter :title
  filter :status, as: :select, collection: %w[draft active archived]
  filter :category
  filter :destination

  index do
    selectable_column
    column :title
    column "Image" do |p|
      image_tag url_for(p.image), width: 50 if p.image.attached?
    end
    column :slug
    column :status
    column :category
    column :destination
    column :position
    actions
  end

  show do
    attributes_table do
      row :title
      row :image do |p|
        image_tag url_for(p.image), width: 200 if p.image.attached?
      end
      row :slug
      row :summary
      row :description
      row :content do |p|
        p.content.to_s.html_safe if p.content.present?
      end
      row :status
      row :category
      row :destination
      row :location_name
      row :position
    end
  end

  form do |f|
    f.inputs "Project" do
      f.input :image, as: :file
      f.input :title
      f.input :slug, hint: "Auto-generated from the title if left blank"
      f.input :summary
      f.input :description, as: :text, input_html: { rows: 4 }
      f.input :content, as: :quill_editor
      f.input :status, as: :select, collection: %w[draft active archived]
      f.input :category
      f.input :destination
      f.input :location_name
      f.input :duration_weeks_min
      f.input :duration_weeks_max
      f.input :position
    end
    f.actions
  end
end
