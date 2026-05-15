class Ability
  include CanCan::Ability

  # Three roles map to three permission sets:
  #
  #   superadmin → can do anything (create/edit/delete other admins)
  #   admin      → manage all content; read AdminUsers but not modify them
  #   editor     → manage their own Posts; read everything else
  def initialize(user)
    return unless user

    # Every signed-in admin can see the dashboard.
    can :read, ActiveAdmin::Page

    case user.role
    when "superadmin"
      can :manage, :all
    when "admin"
      can :manage, [
        Project, Destination, Location, Post, Partner, TeamMember,
        Testimonial, SiteSetting, VolunteerApplication, ContactMessage,
        ActiveAdmin::Comment
      ]
      can :read, AdminUser
      cannot :destroy, AdminUser
    when "editor"
      can :read, [Project, Destination, Location, Partner, TeamMember, Testimonial,
                  SiteSetting, VolunteerApplication, ContactMessage]
      can :create, Post
      can :read,   Post
      can :update, Post, author_id: user.id
      can :destroy, Post, author_id: user.id
    end
  end
end
