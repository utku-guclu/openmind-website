require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "GET / renders the home page" do
    get root_path
    assert_response :success
    assert_select "title", text: /OpenMind Projects/
  end

  test "GET /about renders the about page" do
    get about_path
    assert_response :success
  end

  test "GET /volunteer renders the volunteer page" do
    get volunteer_path
    assert_response :success
  end

  test "GET /research-development renders the R&D page" do
    get research_development_path
    assert_response :success
  end

  test "GET /donate redirects to fundhub" do
    get "/donate"
    assert_response :redirect
    assert_match %r{fundhub\.openskills\.dev}, @response.location
  end
end
