require "application_system_test_case"

class DestinationsTest < ApplicationSystemTestCase
  setup do
    @destination = Destination.create!(name: "Bhutan", status: "active",
                                       summary: "Trek the Himalayas while teaching English.")
  end

  test "browse destinations index → click into one → show page renders" do
    visit destinations_path
    assert_text "Bhutan"

    # Card CTA reads "Explore"; find by href since multiple cards share the text.
    find("a[href='#{destination_path(@destination)}']").click
    assert_current_path destination_path(@destination)
    assert_text "Bhutan"
  end
end
