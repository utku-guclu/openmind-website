require "application_system_test_case"

class ApplyFormTest < ApplicationSystemTestCase
  test "apply page renders the SendImpact iframe" do
    visit new_application_path
    assert_selector "iframe.volunteer-modal__iframe", visible: :all
  end
end
