require "test_helper"

class ContactMessageTest < ActiveSupport::TestCase
  test "valid with name + email" do
    m = ContactMessage.new(name: "Visitor", email: "v@example.com")
    assert m.valid?, m.errors.full_messages.to_sentence
  end

  test "rejects missing email" do
    m = ContactMessage.new(name: "x")
    assert_not m.valid?
    assert_includes m.errors[:email], "can't be blank"
  end

  test "rejects malformed email" do
    m = ContactMessage.new(name: "x", email: "junk")
    assert_not m.valid?
    assert_includes m.errors[:email], "is invalid"
  end

  test "unread scope filters by status" do
    ContactMessage.create!(name: "a", email: "a@b.c", status: "unread")
    ContactMessage.create!(name: "b", email: "b@c.d", status: "read")
    assert_equal 1, ContactMessage.unread.count
  end
end
