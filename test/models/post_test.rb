require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "auto-generates slug from title when blank" do
    p = Post.create!(title: "Hello World")
    assert_equal "hello-world", p.slug
  end

  test "published scope excludes drafts and future-dated posts" do
    Post.create!(title: "Live",     status: "published", published_at: 1.day.ago)
    Post.create!(title: "Draft",    status: "draft",     published_at: 1.day.ago)
    Post.create!(title: "Scheduled", status: "published", published_at: 1.day.from_now)
    assert_equal 1, Post.published.count
  end

  test "to_param uses slug" do
    p = Post.create!(title: "Slug Me")
    assert_equal "slug-me", p.to_param
  end
end
