require "test_helper"

class PartnerTest < ActiveSupport::TestCase
  test "requires name" do
    assert_not Partner.new.valid?
  end

  test "active scope filters by active flag" do
    Partner.create!(name: "On",  active: true)
    Partner.create!(name: "Off", active: false)
    assert_equal 1, Partner.active.count
  end

  test "featured scope filters by tier" do
    Partner.create!(name: "Headliner", tier: "featured")
    Partner.create!(name: "Sidekick",  tier: "supporter")
    assert_equal 1, Partner.featured.count
  end
end
