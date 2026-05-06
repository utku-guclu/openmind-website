# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent volunteer applications" do
          recent = VolunteerApplication.recent.limit(5)
          if recent.any?
            table_for recent do
              column("Name") { |a| link_to a.full_name, admin_volunteer_application_path(a) }
              column :email
              column :application_type
              column :status
              column :created_at
            end
          else
            para "No volunteer applications yet."
          end
        end

        panel "Recent contact messages" do
          recent = ContactMessage.recent.limit(5)
          if recent.any?
            table_for recent do
              column("Name") { |m| link_to m.name, admin_contact_message_path(m) }
              column :subject
              column :status
              column :created_at
            end
          else
            para "No contact messages yet."
          end
        end
      end

      column do
        panel "Content at a glance" do
          ul do
            li "#{Project.active.count} active projects (#{Project.count} total)"
            li "#{Destination.active.count} active destinations (#{Destination.count} total)"
            li "#{Post.published.count} published posts (#{Post.count} total)"
            li "#{Partner.active.count} active partners"
            li "#{TeamMember.active.count} active team members"
          end
        end

        panel "Drafts needing attention" do
          drafts = Post.where(status: "draft").limit(5)
          if drafts.any?
            ul do
              drafts.each { |p| li link_to(p.title, edit_admin_post_path(p)) }
            end
          else
            para "No drafts."
          end
        end

        if current_admin_user&.superadmin?
          panel "Admin users" do
            table_for AdminUser.order(:created_at) do
              column("Email") { |u| link_to u.email, admin_admin_user_path(u) }
              column :role
              column :sign_in_count
              column :last_sign_in_at
            end
          end
        end
      end
    end
  end
end
