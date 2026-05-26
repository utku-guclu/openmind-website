require "test_helper"

class TestimonialTest < ActiveSupport::TestCase
  test "requires name" do
    assert_not Testimonial.new.valid?
  end

  test "featured scope filters by featured flag" do
    Testimonial.create!(name: "A", featured: true)
    Testimonial.create!(name: "B", featured: false)
    assert_equal 1, Testimonial.featured.count
  end
end
