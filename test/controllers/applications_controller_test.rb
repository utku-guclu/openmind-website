require "test_helper"

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "GET /apply/new renders the form" do
    get new_application_path
    assert_response :success
  end

  test "GET /apply/new?type=internship renders success and SendImpact iframe" do
    get new_application_path(type: "internship")
    assert_response :success
    assert_select "iframe.volunteer-modal__iframe"
  end

  test "POST /apply with valid params persists and redirects" do
    assert_difference -> { VolunteerApplication.count }, 1 do
      post applications_path, params: { volunteer_application: {
        first_name: "Asha", last_name: "Patel", email: "asha@example.com",
        application_type: "volunteer_onsite"
      } }
    end
    assert_redirected_to new_application_path
    follow_redirect!
    assert_match(/Thank you/, flash[:notice].to_s)
  end

  test "POST /apply with invalid params re-renders with 422" do
    assert_no_difference -> { VolunteerApplication.count } do
      post applications_path, params: { volunteer_application: { first_name: "" } }
    end
    assert_response :unprocessable_entity
  end
end
