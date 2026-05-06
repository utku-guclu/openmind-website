ActiveAdmin.register ContactMessage do
  permit_params :status

  filter :status, as: :select, collection: %w[unread read archived]
  filter :email
  filter :created_at

  index do
    selectable_column
    column :id
    column :name
    column :email
    column :subject
    column :status
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :subject
      row :message
      row :status
      row :created_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Triage" do
      f.input :status, as: :select, collection: %w[unread read archived]
    end
    f.actions
  end
end
