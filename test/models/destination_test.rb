require "test_helper"

class DestinationTest < ActiveSupport::TestCase
  test "auto-generates slug from name when blank" do
    d = Destination.create!(name: "South Korea")
    assert_equal "south-korea", d.slug
  end

  test "requires unique slug" do
    Destination.create!(name: "Vietnam")
    dup = Destination.new(name: "Vietnam")
    assert_not dup.valid?
    assert_includes dup.errors[:slug], "has already been taken"
  end

  test "country_code must be exactly 2 chars when present" do
    d = Destination.new(name: "Foo", country_code: "USA")
    assert_not d.valid?
    assert_includes d.errors[:country_code], "is the wrong length (should be 2 characters)"
  end

  test "active scope returns only status='active'" do
    Destination.create!(name: "On",  status: "active")
    Destination.create!(name: "Off", status: "draft")
    assert_equal 1, Destination.active.count
  end

  test "ordered scope sorts by position ascending" do
    a = Destination.create!(name: "A", position: 2)
    b = Destination.create!(name: "B", position: 1)
    assert_equal [b, a], Destination.where(id: [a.id, b.id]).ordered.to_a
  end
end
