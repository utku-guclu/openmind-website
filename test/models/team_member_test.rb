require "test_helper"

class TeamMemberTest < ActiveSupport::TestCase
  test "requires name and role" do
    m = TeamMember.new
    assert_not m.valid?
    assert_includes m.errors[:name], "can't be blank"
    assert_includes m.errors[:role], "can't be blank"
  end

  test "active scope filters by active flag" do
    TeamMember.create!(name: "A", role: "Founder", active: true)
    TeamMember.create!(name: "B", role: "Past",    active: false)
    assert_equal 1, TeamMember.active.count
  end
end
