ActiveAdmin.register SiteSetting do
  permit_params :key, :value, :value_type

  filter :key
  filter :value_type, as: :select, collection: %w[string integer boolean json]

  index do
    selectable_column
    column :key
    column :value
    column :value_type
    actions
  end

  form do |f|
    f.inputs "Site Setting" do
      f.input :key, hint: "Unique identifier (snake_case). Read in views via SiteSetting.get(key)."
      f.input :value
      f.input :value_type, as: :select, collection: %w[string integer boolean json]
    end
    f.actions
  end
end
