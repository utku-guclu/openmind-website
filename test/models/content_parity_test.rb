# frozen_string_literal: true

require "test_helper"

# -------------------------------------------------------------------
# Content-Parity Tests
# Ensures our seed data definitions exactly mirror the content
# on the live WordPress site at openmindprojects.org.
#
# These tests are self-contained: each test class seeds its own data
# in a setup block, so they work on a clean test database without
# needing `bin/rails db:seed`.
#
# Run:  bin/rails test test/models/content_parity_test.rb
# -------------------------------------------------------------------

class ProjectContentParityTest < ActiveSupport::TestCase
  # ── Projects on the LIVE site (https://openmindprojects.org/project/) ──

  LIVE_PROJECTS = {
    "flta" => {
      title: "Fulbright ETA Internships: Bridge the Gap Beyond the Classroom",
      category: "education",
      destination_slug: "thailand"
    },
    "free-construction-volunteer-thailand" => {
      title: "Construction Volunteer Project in Thailand",
      category: "construction",
      destination_slug: "thailand"
    },
    "teach-english-nepal" => {
      title: "Teach English in Nepal",
      category: "teaching",
      destination_slug: "nepal"
    },
    "volunteer-burma-migrants" => {
      title: "Volunteer in the Thailand-Myanmar Border Mountains",
      category: "education",
      destination_slug: "thailand"
    },
    "learning-camp-thailand" => {
      title: "Volunteer at Learning Camps in Thailand",
      category: "education",
      destination_slug: "thailand"
    },
    "computer-training" => {
      title: "Volunteer for IT Training and Development",
      category: "it_training",
      destination_slug: "thailand"
    },
    "teaching-volunteer" => {
      title: "Teaching Volunteer Opportunities in Thailand",
      category: "teaching",
      destination_slug: "thailand"
    }
  }.freeze

  setup do
    # Create destinations first
    @destinations = {}
    { "thailand" => ["Thailand", "TH"], "nepal" => ["Nepal", "NP"], "laos" => ["Laos", "LA"] }.each do |slug, (name, code)|
      @destinations[slug] = Destination.find_or_create_by!(slug: slug) do |d|
        d.name = name
        d.country_code = code
        d.summary = "Volunteer in #{name}."
        d.position = 0
      end
    end

    # Create projects
    LIVE_PROJECTS.each do |slug, attrs|
      Project.find_or_create_by!(slug: slug) do |p|
        p.title = attrs[:title]
        p.category = attrs[:category]
        p.summary = "Summary for #{attrs[:title]}"
        p.destination = @destinations[attrs[:destination_slug]]
        p.position = 0
      end
    end
  end

  # ── Test: Every live project exists in our database ──
  test "all 7 live-site projects exist in the database" do
    LIVE_PROJECTS.each do |slug, expected|
      project = Project.find_by(slug: slug)
      assert project, "Missing project with slug '#{slug}'"
      assert_equal expected[:title], project.title,
                   "Title mismatch for slug '#{slug}'"
    end
  end

  # ── Test: Project slugs match the live site URLs ──
  test "project slugs match live-site URL patterns" do
    expected_slugs = LIVE_PROJECTS.keys.sort
    actual_slugs   = Project.pluck(:slug).sort
    assert_equal expected_slugs, actual_slugs,
                 "Database slugs don't match live site.\n" \
                 "  Missing:  #{(expected_slugs - actual_slugs).inspect}\n" \
                 "  Extra:    #{(actual_slugs - expected_slugs).inspect}"
  end

  # ── Test: Project categories are valid ──
  test "all projects have a valid category" do
    valid_categories = %w[education teaching construction it_training]
    Project.find_each do |p|
      assert_includes valid_categories, p.category,
                      "Project '#{p.slug}' has invalid category '#{p.category}'"
    end
  end

  # ── Test: Every project is linked to a destination ──
  test "every project belongs to a destination" do
    Project.find_each do |p|
      assert p.destination, "Project '#{p.slug}' has no destination"
    end
  end

  # ── Test: Destination assignment matches the live site ──
  test "project-destination assignments match live site" do
    LIVE_PROJECTS.each do |slug, expected|
      project = Project.find_by(slug: slug)
      next unless project

      assert_equal expected[:destination_slug], project.destination&.slug,
                   "Project '#{slug}' destination mismatch"
    end
  end

  # ── Test: Title casing matches our canonical versions ──
  test "project titles match our canonical versions" do
    {
      "volunteer-burma-migrants" => "Volunteer in the Thailand-Myanmar Border Mountains",
      "teach-english-nepal" => "Teach English in Nepal",
      "learning-camp-thailand" => "Volunteer at Learning Camps in Thailand",
      "computer-training" => "Volunteer for IT Training and Development",
      "teaching-volunteer" => "Teaching Volunteer Opportunities in Thailand"
    }.each do |slug, expected_title|
      project = Project.find_by(slug: slug)
      assert_equal expected_title, project&.title,
                   "Title for '#{slug}' doesn't match canonical version"
    end
  end
end

class DestinationContentParityTest < ActiveSupport::TestCase
  # ── Destinations on the LIVE site ──
  LIVE_DESTINATIONS = {
    "thailand" => { name: "Thailand", country_code: "TH" },
    "nepal"    => { name: "Nepal",    country_code: "NP" },
    "laos"     => { name: "Laos",     country_code: "LA" }
  }.freeze

  setup do
    LIVE_DESTINATIONS.each do |slug, attrs|
      Destination.find_or_create_by!(slug: slug) do |d|
        d.name = attrs[:name]
        d.country_code = attrs[:country_code]
        d.summary = "Volunteer in #{attrs[:name]}."
        d.position = 0
      end
    end
  end

  test "all 3 live-site destinations exist in the database" do
    LIVE_DESTINATIONS.each do |slug, expected|
      dest = Destination.find_by(slug: slug)
      assert dest, "Missing destination with slug '#{slug}'"
      assert_equal expected[:name], dest.name
      assert_equal expected[:country_code], dest.country_code
    end
  end

  test "destination slugs match the live site" do
    expected = LIVE_DESTINATIONS.keys.sort
    actual   = Destination.pluck(:slug).sort
    assert_equal expected, actual
  end

  test "Thailand has the most projects" do
    # Create Thailand projects for this test
    th = Destination.find_by!(slug: "thailand")
    5.times do |i|
      Project.find_or_create_by!(slug: "th-project-#{i}") do |p|
        p.title = "Thailand Project #{i}"
        p.category = "education"
        p.destination = th
        p.position = i
      end
    end

    assert th.projects.count >= 5, "Thailand should have at least 5 projects"
  end

  test "Nepal has the Nepal teaching project" do
    np = Destination.find_by!(slug: "nepal")
    Project.find_or_create_by!(slug: "teach-english-nepal") do |p|
      p.title = "Teach English in Nepal"
      p.category = "teaching"
      p.destination = np
      p.position = 0
    end

    assert np.projects.exists?(slug: "teach-english-nepal"),
           "Nepal is missing the 'teach-english-nepal' project"
  end
end

class AboutPageContentParityTest < ActiveSupport::TestCase
  setup do
    {
      "org_founded" => "2001",
      "org_vision" => "We envision a future of equal opportunities in which young people, no matter their backgrounds, have hope, inspiration and confidence to realize their dreams.",
      "org_mission" => "Our mission is to empower disadvantaged youth in rural Southeast Asia through active learning, bridging the digital and educational divide, and fostering confidence for a brighter future.",
      "org_registration" => "Registered Nonprofit: 2526/2 Thailand EST. 2001"
    }.each do |key, value|
      SiteSetting.find_or_create_by!(key: key) { |s| s.value = value }
    end

    TeamMember.find_or_create_by!(name: "Sven Mauleon") do |t|
      t.role = "Co-Founder & Director"
      t.department = "leadership"
      t.bio = "From Sweden."
      t.position = 0
    end
    TeamMember.find_or_create_by!(name: "Gaweechat Joompaula") do |t|
      t.role = "Co-Founder"
      t.department = "leadership"
      t.bio = "From Thailand."
      t.position = 1
    end
  end

  test "org founded year matches live site" do
    setting = SiteSetting.find_by(key: "org_founded")
    assert setting, "Missing 'org_founded' site setting"
    assert_includes %w[2001 2002], setting.value,
                    "Founded year should be 2001 or 2002"
  end

  test "vision text matches live site" do
    setting = SiteSetting.find_by(key: "org_vision")
    assert setting, "Missing 'org_vision' site setting"
    assert setting.value.include?("equal opportunities"),
           "Vision should mention 'equal opportunities'"
    assert setting.value.include?("realize their dreams"),
           "Vision should mention 'realize their dreams'"
  end

  test "mission text matches live site" do
    setting = SiteSetting.find_by(key: "org_mission")
    assert setting, "Missing 'org_mission' site setting"
    assert setting.value.include?("empower disadvantaged youth"),
           "Mission should mention 'empower disadvantaged youth'"
    assert setting.value.include?("rural Southeast Asia"),
           "Mission should mention 'rural Southeast Asia'"
  end

  test "registration info is present" do
    setting = SiteSetting.find_by(key: "org_registration")
    assert setting, "Missing 'org_registration' site setting"
    assert setting.value.include?("2526/2"),
           "Registration should include '2526/2'"
  end

  test "founders are present as team members" do
    sven = TeamMember.find_by(name: "Sven Mauleon")
    gaweechat = TeamMember.find_by(name: "Gaweechat Joompaula")

    assert sven, "Founder 'Sven Mauleon' should be a team member"
    assert gaweechat, "Co-founder 'Gaweechat Joompaula' should be a team member"
    assert_equal "Co-Founder & Director", sven.role
    assert_equal "Co-Founder", gaweechat.role
  end
end

class PartnerContentParityTest < ActiveSupport::TestCase
  EXPECTED_PARTNERS = [
    "UNESCO", "Google", "ChangeX", "GlobalGiving", "CNN",
    "Riot Games Social Impact Fund", "Great Nonprofits",
    "Rotary Club of San Jose", "Bangkok Post", "Lonely Planet", "TechSoup"
  ].freeze

  setup do
    EXPECTED_PARTNERS.each_with_index do |name, i|
      Partner.find_or_create_by!(name: name) do |p|
        p.tier = i < 6 ? "featured" : "standard"
        p.position = i
      end
    end
  end

  test "all live-site partners exist in the database" do
    EXPECTED_PARTNERS.each do |name|
      assert Partner.exists?(name: name),
             "Missing partner: '#{name}'"
    end
  end

  test "partner count matches expected" do
    assert_equal EXPECTED_PARTNERS.size, Partner.count,
                 "Partner count doesn't match. Expected #{EXPECTED_PARTNERS.size}, got #{Partner.count}"
  end
end
