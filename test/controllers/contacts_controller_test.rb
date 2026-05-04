require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "GET /contact/new renders the form" do
    get new_contact_path
    assert_response :success
  end

  test "POST /contact with valid params persists and redirects" do
    assert_difference -> { ContactMessage.count }, 1 do
      post contact_path, params: { contact_message: {
        name: "Visitor", email: "v@example.com", subject: "Hello", message: "Just saying hi."
      } }
    end
    assert_redirected_to new_contact_path
    follow_redirect!
    assert_match(/Thank you/, flash[:notice].to_s)
  end

  test "POST /contact with invalid params re-renders with 422" do
    assert_no_difference -> { ContactMessage.count } do
      post contact_path, params: { contact_message: { name: "", email: "" } }
    end
    assert_response :unprocessable_entity
  end
end
