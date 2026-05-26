require "test_helper"

class VolunteerApplicationTest < ActiveSupport::TestCase
  def valid_attrs
    { first_name: "Asha", last_name: "Patel", email: "asha@example.com" }
  end

  test "valid with required name + email" do
    a = VolunteerApplication.new(valid_attrs)
    assert a.valid?, a.errors.full_messages.to_sentence
  end

  test "rejects bad email" do
    a = VolunteerApplication.new(valid_attrs.merge(email: "not-an-email"))
    assert_not a.valid?
    assert_includes a.errors[:email], "is invalid"
  end

  test "application_type must be in whitelist when present" do
    a = VolunteerApplication.new(valid_attrs.merge(application_type: "freelance"))
    assert_not a.valid?
    a.application_type = "volunteer_onsite"
    assert a.valid?
  end

  test "full_name concatenates first and last" do
    a = VolunteerApplication.new(valid_attrs)
    assert_equal "Asha Patel", a.full_name
  end

  test "pending scope filters by status" do
    VolunteerApplication.create!(valid_attrs.merge(status: "pending"))
    VolunteerApplication.create!(valid_attrs.merge(email: "x@y.z", status: "approved"))
    assert_equal 1, VolunteerApplication.pending.count
  end
end
