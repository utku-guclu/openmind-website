ActiveAdmin.register Location do
  menu parent: "Programs", priority: 4
  permit_params :name, :slug, :region, :summary, :destination_id,
                :status, :position, :latitude, :longitude

  controller do
    defaults finder: :find_by_slug!
  end

  filter :name
  filter :destination
  filter :status, as: :select, collection: %w[active inactive]

  index do
    selectable_column
    column :name
    column :region
    column :destination
    column :status
    column :position
    column "Projects" do |loc|
      loc.projects.count
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :slug
      row :region
      row :summary
      row :destination
      row :status
      row :position
      row :latitude
      row :longitude
      row "Projects" do |loc|
        loc.projects.pluck(:title).join(", ")
      end
    end
  end

  form do |f|
    f.inputs "Location" do
      f.input :name
      f.input :slug, hint: "Auto-generated if blank: <destination-slug>-<name>"
      f.input :region, hint: "Province or region label shown under the name"
      f.input :summary, as: :text, input_html: { rows: 3 }
      f.input :destination, as: :select, collection: Destination.visible.ordered
      f.input :status, as: :select, collection: %w[active inactive]
      f.input :position
      f.input :latitude
      f.input :longitude
    end
    f.actions
  end
end
