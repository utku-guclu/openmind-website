require "application_system_test_case"

class ContactFormTest < ApplicationSystemTestCase
  test "submitting the contact form persists a ContactMessage and shows the thank-you" do
    visit new_contact_path

    fill_in "Name",    with: "Visitor"
    fill_in "Email",   with: "visitor@example.com"
    fill_in "Subject", with: "Hello there"
    fill_in "Message", with: "Just wanted to say I love what you're doing."

    click_button "Send Message"

    assert_text "Thank you", normalize_ws: true

    record = ContactMessage.find_by(email: "visitor@example.com")
    assert record, "expected a ContactMessage for visitor@example.com"
    assert_equal "Visitor", record.name
  end
end
