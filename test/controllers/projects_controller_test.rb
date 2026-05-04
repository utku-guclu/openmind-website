require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = Project.create!(title: "Reef Cleanup", status: "active", category: "construction")
  end

  test "GET /projects renders the index" do
    get projects_path
    assert_response :success
  end

  test "GET /projects?category=education filters" do
    get projects_path(category: "education")
    assert_response :success
  end

  test "GET /projects/:slug renders the show page" do
    get project_path(@project)
    assert_response :success
  end

  test "GET /projects/missing returns 404" do
    get project_path("does-not-exist")
    assert_response :not_found
  end
end
