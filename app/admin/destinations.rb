ActiveAdmin.register Destination do
  menu parent: "Programs", priority: 3
  permit_params :name, :slug, :country_code, :summary, :description,
                :latitude, :longitude, :status, :position

  # Model uses slug as `to_param`, so URLs are /admin/destinations/laos.
  # Tell ActiveAdmin to look up by slug instead of id.
  controller do
    defaults finder: :find_by_slug!
  end

  filter :name
  filter :country_code
  filter :status, as: :select, collection: %w[draft active archived]

  index do
    selectable_column
    column :name
    column :slug
    column :country_code
    column :status
    column :position
    actions
  end

  form do |f|
    f.inputs "Destination" do
      f.input :name
      f.input :slug, hint: "Auto-generated from the name if left blank"
      f.input :country_code, hint: "ISO 3166-1 alpha-2 (e.g. TH, LA, NP)"
      f.input :summary
      f.input :description, as: :text, input_html: { rows: 8 }
      f.input :latitude
      f.input :longitude
      f.input :status, as: :select, collection: %w[draft active archived]
      f.input :position
    end
    f.actions
  end
end
