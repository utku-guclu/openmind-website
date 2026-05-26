# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # ── Stats Row ──────────────────────────────────────────────────
    div style: "display:grid; grid-template-columns:repeat(auto-fit, minmax(180px, 1fr)); gap:16px; margin-bottom:28px;" do
      [
        { label: "Active Projects",    count: Project.active.count,          icon: "📁", color: "#0C7ABF" },
        { label: "Destinations",       count: Destination.active.count,      icon: "🌏", color: "#4CAF50" },
        { label: "Applications",       count: VolunteerApplication.count,    icon: "📬", color: "#E89B1C" },
        { label: "Published Posts",    count: Post.published.count,          icon: "📝", color: "#5DADE2" },
        { label: "Team Members",       count: TeamMember.active.count,       icon: "👥", color: "#6B8EC7" },
        { label: "Partners",           count: Partner.active.count,          icon: "🤝", color: "#008B8B" }
      ].each do |stat|
        div style: "background:#fff; border-radius:10px; padding:20px; border:1px solid #E2E8F0; box-shadow:0 1px 3px rgba(0,0,0,.04); display:flex; align-items:center; gap:16px;" do
          div style: "width:48px; height:48px; border-radius:10px; background:#{stat[:color]}12; display:flex; align-items:center; justify-content:center; font-size:1.4rem;" do
            stat[:icon]
          end
          div do
            div style: "font-size:1.6rem; font-weight:700; color:#2C3E50; line-height:1.2;" do
              stat[:count].to_s
            end
            div style: "font-size:.75rem; font-weight:600; color:#5D6D7E; text-transform:uppercase; letter-spacing:.04em;" do
              stat[:label]
            end
          end
        end
      end
    end

    columns do
      column do
        panel "Recent Volunteer Applications" do
          recent = VolunteerApplication.recent.limit(5)
          if recent.any?
            table_for recent do
              column("Name") { |a| link_to a.full_name, admin_volunteer_application_path(a) }
              column :email
              column :application_type
              column("Status") { |a| status_tag a.status }
              column("Submitted") { |a| time_ago_in_words(a.created_at) + " ago" }
            end
          else
            div style: "text-align:center; padding:32px; color:#5D6D7E;" do
              "No volunteer applications yet."
            end
          end
        end

        panel "Recent Contact Messages" do
          recent = ContactMessage.recent.limit(5)
          if recent.any?
            table_for recent do
              column("Name") { |m| link_to m.name, admin_contact_message_path(m) }
              column :subject
              column("Status") { |m| status_tag m.status }
              column("Received") { |m| time_ago_in_words(m.created_at) + " ago" }
            end
          else
            div style: "text-align:center; padding:32px; color:#5D6D7E;" do
              "No contact messages yet."
            end
          end
        end
      end

      column do
        panel "Drafts Needing Attention" do
          drafts = Post.where(status: "draft").limit(5)
          if drafts.any?
            table_for drafts do
              column("Title") { |p| link_to p.title, edit_admin_post_path(p) }
              column("Created") { |p| time_ago_in_words(p.created_at) + " ago" }
            end
          else
            div style: "text-align:center; padding:24px; color:#5D6D7E;" do
              "✨ No drafts — all content is published!"
            end
          end
        end

        panel "Quick Links" do
          div style: "display:grid; grid-template-columns:1fr 1fr; gap:10px; padding:4px 0;" do
            [
              { label: "New Project", path: new_admin_project_path, icon: "➕" },
              { label: "New Post", path: new_admin_post_path, icon: "📝" },
              { label: "Site Settings", path: admin_site_settings_path, icon: "⚙️" },
              { label: "View Site", path: root_path, icon: "🌐" }
            ].each do |link|
              a href: link[:path], style: "display:flex; align-items:center; gap:10px; padding:12px 16px; background:#F0F4F8; border-radius:8px; color:#2C3E50; text-decoration:none; font-weight:600; font-size:.85rem; transition:all .15s;" do
                span { link[:icon] }
                span { link[:label] }
              end
            end
          end
        end

        if current_admin_user&.superadmin?
          panel "Admin Users" do
            table_for AdminUser.order(:created_at) do
              column("Email") { |u| link_to u.email, admin_admin_user_path(u) }
              column("Role") { |u| status_tag u.role }
              column :sign_in_count
              column("Last Sign In") { |u| u.last_sign_in_at ? time_ago_in_words(u.last_sign_in_at) + " ago" : "Never" }
            end
          end
        end
      end
    end
  end
end
