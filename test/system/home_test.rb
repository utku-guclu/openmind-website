require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  test "home page renders with header, hero, and donate CTA" do
    visit root_path
    assert_selector "title", text: /OpenMind/, visible: :all
    assert_selector "nav.navbar"
    assert_text "Donate", normalize_ws: true
  end

  test "header nav links lead to the right pages" do
    visit root_path
    within "nav.navbar" do
      click_on "About"
    end
    assert_current_path about_path

    visit root_path
    within "nav.navbar" do
      click_on "Projects"
    end
    assert_current_path projects_path

    visit root_path
    within "nav.navbar" do
      click_on "Destinations"
    end
    assert_current_path destinations_path
  end
end
