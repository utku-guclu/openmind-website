require "application_system_test_case"

class AdminRoleTest < ApplicationSystemTestCase
  setup do
    @superadmin = AdminUser.create!(email: "super@example.com", password: "secret12345",
                                    name: "Super", role: "superadmin")
    @editor     = AdminUser.create!(email: "editor@example.com", password: "secret12345",
                                    name: "Editor", role: "editor")
  end

  def sign_in_as(user, password)
    visit "/admin/login"
    fill_in "Email",    with: user.email
    fill_in "Password", with: password
    click_button "Login"
  end

  test "superadmin sees Admin Users in the menu and can open it" do
    sign_in_as(@superadmin, "secret12345")
    assert_selector "a", text: "Admin Users"
    click_on "Admin Users"
    assert_current_path "/admin/admin_users"
  end

  test "editor cannot reach the Admin Users page (redirected to dashboard)" do
    sign_in_as(@editor, "secret12345")
    visit "/admin/admin_users"
    # CanCanCan denies access; access_denied handler in ApplicationController
    # redirects back to the dashboard.
    assert_current_path "/admin"
  end

  test "editor lands on dashboard and can browse posts" do
    sign_in_as(@editor, "secret12345")
    assert_text "Dashboard"
    visit "/admin/posts"
    assert_text "Posts"
  end
end
