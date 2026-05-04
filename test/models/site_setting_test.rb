require "test_helper"

class SiteSettingTest < ActiveSupport::TestCase
  test "requires unique key" do
    SiteSetting.create!(key: "site_name", value: "OMP")
    dup = SiteSetting.new(key: "site_name", value: "Other")
    assert_not dup.valid?
    assert_includes dup.errors[:key], "has already been taken"
  end

  test "set and get round-trip a string" do
    SiteSetting.set("tagline", "Hello world")
    assert_equal "Hello world", SiteSetting.get("tagline")
  end

  test "typed_value casts integers" do
    SiteSetting.set("count", "42", type: "integer")
    assert_equal 42, SiteSetting.get("count")
  end

  test "typed_value casts booleans" do
    SiteSetting.set("flag", "true", type: "boolean")
    assert_equal true, SiteSetting.get("flag")
  end

  test "get returns default when key missing" do
    assert_equal "fallback", SiteSetting.get("missing_key", "fallback")
  end
end
