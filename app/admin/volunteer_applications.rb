ActiveAdmin.register VolunteerApplication do
  # Editors don't usually edit applications; they review and update status / admin_notes.
  permit_params :status, :admin_notes

  filter :status, as: :select, collection: %w[pending reviewing approved rejected withdrawn]
  filter :application_type
  filter :email
  filter :destination
  filter :project
  filter :created_at

  index do
    selectable_column
    column :id
    column "Name", &:full_name
    column :email
    column :application_type
    column :status
    column :project
    column :destination
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :phone
      row :nationality
      row :date_of_birth
      row :application_type
      row :project
      row :destination
      row :preferred_start_date
      row :duration_weeks
      row :skills
      row :motivation
      row :experience
      row :status
      row :admin_notes
      row :created_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Review" do
      f.input :status, as: :select,
              collection: %w[pending reviewing approved rejected withdrawn]
      f.input :admin_notes, as: :text, input_html: { rows: 6 }
    end
    f.actions
  end
end
