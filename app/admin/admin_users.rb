ActiveAdmin.register AdminUser do
  menu parent: "Settings", priority: 2
  permit_params :email, :name, :role, :password, :password_confirmation

  filter :email
  filter :name
  filter :role, as: :select, collection: AdminUser::ROLES
  filter :sign_in_count

  index do
    selectable_column
    column :email
    column :name
    column :role
    column :sign_in_count
    column :last_sign_in_at
    actions
  end

  form do |f|
    f.inputs "Admin User" do
      f.input :email
      f.input :name
      f.input :role, as: :select, collection: AdminUser::ROLES,
              hint: "superadmin = manage everyone · admin = manage content · editor = own posts only"
      f.input :password,              hint: f.object.new_record? ? "Required" : "Leave blank to keep current"
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def update
      # Don't update password if blank
      if params[:admin_user][:password].blank?
        params[:admin_user].delete(:password)
        params[:admin_user].delete(:password_confirmation)
      end
      super
    end
  end
end
