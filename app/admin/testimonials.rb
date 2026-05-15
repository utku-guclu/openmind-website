ActiveAdmin.register Testimonial do
  permit_params :name, :role, :country, :quote, :video_url, :featured,
                :position, :project_id

  filter :name
  filter :country
  filter :featured
  filter :project

  index do
    selectable_column
    column :name
    column :role
    column :country
    column :project
    column :featured
    column :position
    actions
  end

  form do |f|
    f.inputs "Testimonial" do
      f.input :name
      f.input :role
      f.input :country, as: :string
      f.input :project
      f.input :quote, as: :text, input_html: { rows: 6 }
      f.input :video_url
      f.input :featured
      f.input :position
    end
    f.actions
  end
end
