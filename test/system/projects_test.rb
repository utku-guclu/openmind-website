require "application_system_test_case"

class ProjectsTest < ApplicationSystemTestCase
  setup do
    @project = Project.create!(
      title: "Reef Cleanup", status: "active",
      summary: "Help us pull plastic out of the Andaman Sea."
    )
  end

  test "browse projects index → click into a project → show page renders" do
    visit projects_path
    assert_text "Reef Cleanup"

    # Click the card's CTA — find by href since the visible text "Learn More"
    # is the same on every card.
    find("a[href='#{project_path(@project)}']").click
    assert_current_path project_path(@project)
    assert_text "Reef Cleanup"
  end
end
