require "application_system_test_case"

class AdminLoginTest < ApplicationSystemTestCase
  setup do
    @superadmin = AdminUser.create!(email: "boss@example.com", password: "supersecret123",
                                    name: "Boss", role: "superadmin")
  end

  test "superadmin can sign in and reach the dashboard" do
    visit "/admin/login"
    fill_in "Email",    with: @superadmin.email
    fill_in "Password", with: "supersecret123"
    click_button "Login"

    assert_text "Signed in successfully"
    assert_text "Dashboard"
  end

  test "wrong password keeps them on the login page" do
    visit "/admin/login"
    fill_in "Email",    with: @superadmin.email
    fill_in "Password", with: "wrong"
    click_button "Login"

    assert_text "Invalid email or password"
    assert_no_text "Dashboard"
  end
end
