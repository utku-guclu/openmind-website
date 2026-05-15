ActiveAdmin.register TeamMember do
  permit_params :name, :role, :department, :bio, :linkedin_url, :github_url,
                :active, :position, :country, :image

  filter :name
  filter :role
  filter :department
  filter :active

  index do
    selectable_column
    column :name
    column "Image" do |tm|
      image_tag url_for(tm.image), width: 50 if tm.image.attached?
    end
    column :role
    column :country
    column :department
    column :active
    column :position
    actions
  end

  show do
    attributes_table do
      row :name
      row :image do |tm|
        image_tag url_for(tm.image), width: 200 if tm.image.attached?
      end
      row :role
      row :country
      row :department
      row :bio
      row :linkedin_url
      row :github_url
      row :active
      row :position
    end
  end

  form do |f|
    f.inputs "Team Member" do
      f.input :name
      f.input :image, as: :file
      f.input :role
      f.input :country, as: :string, hint: "e.g., Thailand, Nepal, USA"
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
