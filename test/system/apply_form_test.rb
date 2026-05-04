require "application_system_test_case"

class ApplyFormTest < ApplicationSystemTestCase
  test "submitting the apply form persists a VolunteerApplication and shows the thank-you" do
    visit new_application_path

    # Rails defaults humanize labels with only the first letter capitalized.
    fill_in "First name", with: "Asha"
    fill_in "Last name",  with: "Patel"
    fill_in "Email",      with: "asha@example.com"
    select  "Onsite Volunteering", from: "Program Type"

    click_button "Submit Application"

    # Wait for the redirect + flash before counting — system tests run Puma in
    # another thread, so use the rendered UI as the synchronization point
    # rather than relying on assert_difference cross-thread visibility.
    assert_text "Thank you", normalize_ws: true

    record = VolunteerApplication.find_by(email: "asha@example.com")
    assert record, "expected a VolunteerApplication for asha@example.com"
    assert_equal "Asha",              record.first_name
    assert_equal "volunteer_onsite",  record.application_type
  end

  test "submitting empty form does not advance past /apply/new (browser-side required)" do
    visit new_application_path
    click_button "Submit Application"
    # Required HTML5 fields keep the form on the page; the URL doesn't change.
    assert_current_path new_application_path
  end
end
