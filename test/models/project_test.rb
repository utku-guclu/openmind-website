require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "auto-generates slug from title when blank" do
    p = Project.create!(title: "Teach English in Nepal")
    assert_equal "teach-english-in-nepal", p.slug
  end

  test "requires unique slug" do
    Project.create!(title: "Solar Build")
    dup = Project.new(title: "Solar Build")
    assert_not dup.valid?
    assert_includes dup.errors[:slug], "has already been taken"
  end

  test "to_param returns slug for friendly URLs" do
    p = Project.create!(title: "Rainforest Cleanup")
    assert_equal "rainforest-cleanup", p.to_param
  end

  test "active scope filters by status" do
    Project.create!(title: "Live",   status: "active")
    Project.create!(title: "Hidden", status: "draft")
    assert_equal 1, Project.active.count
  end

  test "by_category returns all when category is blank, filters when present" do
    Project.create!(title: "A", category: "education")
    Project.create!(title: "B", category: "construction")
    assert_equal 2, Project.by_category(nil).count
    assert_equal 1, Project.by_category("education").count
  end
end
