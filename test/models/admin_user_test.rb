require "test_helper"

class AdminUserTest < ActiveSupport::TestCase
  test "valid with email + role + password" do
    u = AdminUser.new(email: "ada@example.com", role: "editor", password: "s3cret123")
    assert u.valid?, u.errors.full_messages.to_sentence
  end

  test "rejects unknown role" do
    u = AdminUser.new(email: "x@y.z", role: "nope", password: "s3cret123")
    assert_not u.valid?
    assert_includes u.errors[:role], "is not included in the list"
  end

  test "rejects malformed email" do
    u = AdminUser.new(email: "not-an-email", role: "admin", password: "s3cret123")
    assert_not u.valid?
    assert_includes u.errors[:email], "is invalid"
  end

  test "rejects duplicate email" do
    AdminUser.create!(email: "dup@example.com", role: "admin", password: "s3cret123")
    dup = AdminUser.new(email: "dup@example.com", role: "admin", password: "s3cret123")
    assert_not dup.valid?
    assert_includes dup.errors[:email], "has already been taken"
  end

  test "authenticates with bcrypt via Devise" do
    u = AdminUser.create!(email: "auth@example.com", role: "admin", password: "s3cret123")
    assert u.valid_password?("s3cret123")
    assert_not u.valid_password?("wrong")
  end
end
