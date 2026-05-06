ActiveAdmin.register TeamMember do
  permit_params :name, :role, :department, :bio, :linkedin_url, :github_url,
                :active, :position

  filter :name
  filter :role
  filter :department
  filter :active

  index do
    selectable_column
    column :name
    column :role
    column :department
    column :active
    column :position
    actions
  end

  form do |f|
    f.inputs "Team Member" do
      f.input :name
      f.input :role
      f.input :department
      f.input :bio, as: :text, input_html: { rows: 6 }
      f.input :linkedin_url
      f.input :github_url
      f.input :active
      f.input :position
    end
    f.actions
  end
end
