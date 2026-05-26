ActiveAdmin.register Partner do
  menu parent: "Content", priority: 3
  permit_params :name, :url, :tier, :active, :position

  filter :name
  filter :tier, as: :select, collection: %w[featured supporter]
  filter :active

  index do
    selectable_column
    column :name
    column :tier
    column :url
    column :active
    column :position
    actions
  end

  form do |f|
    f.inputs "Partner" do
      f.input :name
      f.input :url
      f.input :tier, as: :select, collection: %w[featured supporter]
      f.input :active
      f.input :position
    end
    f.actions
  end
end
