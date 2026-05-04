require "test_helper"

class DestinationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @destination = Destination.create!(name: "Bhutan", status: "active")
  end

  test "GET /destinations renders the index" do
    get destinations_path
    assert_response :success
  end

  test "GET /destinations/:slug renders the show page" do
    get destination_path(@destination)
    assert_response :success
  end

  test "GET /destinations/missing returns 404" do
    get destination_path("not-a-real-slug")
    assert_response :not_found
  end
end
