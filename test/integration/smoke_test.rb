# frozen_string_literal: true

require "test_helper"

# -------------------------------------------------------------------
# Smoke Tests — Every Public Page Renders Without Error
# Run these BEFORE opening localhost to catch routing, view, and
# controller errors early.
#
# Run:  bin/rails test test/integration/smoke_test.rb
# -------------------------------------------------------------------

class SmokeTest < ActionDispatch::IntegrationTest
  setup do
    # Seed minimal data so pages that query the DB don't blow up
    @thailand = Destination.find_or_create_by!(slug: "thailand") do |d|
      d.name = "Thailand"
      d.country_code = "TH"
      d.summary = "Volunteer in Thailand."
      d.position = 0
    end

    @nepal = Destination.find_or_create_by!(slug: "nepal") do |d|
      d.name = "Nepal"
      d.country_code = "NP"
      d.summary = "Volunteer in Nepal."
      d.position = 1
    end

    @laos = Destination.find_or_create_by!(slug: "laos") do |d|
      d.name = "Laos"
      d.country_code = "LA"
      d.summary = "Volunteer in Laos."
      d.position = 2
    end

    @project = Project.find_or_create_by!(slug: "teach-english-nepal") do |p|
      p.title = "Teach English in Nepal"
      p.category = "teaching"
      p.summary = "Teach English."
      p.destination = @nepal
      p.position = 0
    end

    Project.find_or_create_by!(slug: "teaching-volunteer") do |p|
      p.title = "Teaching Volunteer Opportunities in Thailand"
      p.category = "teaching"
      p.summary = "Teach in Thailand."
      p.destination = @thailand
      p.position = 1
    end

    Partner.find_or_create_by!(name: "UNESCO") do |p|
      p.tier = "featured"
      p.position = 0
    end

    TeamMember.find_or_create_by!(name: "Sven Mauleon") do |t|
      t.role = "Co-Founder & Director"
      t.department = "leadership"
      t.bio = "From Sweden."
      t.position = 0
    end

    {
      "hero_title" => "Fight Poverty with Education",
      "hero_subtitle" => "Ethical volunteer work in Southeast Asia.",
      "org_mission" => "Empower disadvantaged youth.",
      "org_vision" => "Equal opportunities for all.",
      "org_founded" => "2001",
      "org_registration" => "Registered Nonprofit: 2526/2 Thailand EST. 2001",
      "org_story" => "A nonprofit charity founded in Thailand.",
      "org_founders_intro" => "East meets West!",
      "org_video_url" => "https://www.youtube.com/embed/C7f0yJFX3DA",
      "org_video_title" => "Impact video",
      "org_press_url" => "http://example.com",
      "org_press_title" => "Press article",
      "impact_years" => "20",
      "impact_students" => "5000",
      "impact_countries" => "3",
      "impact_volunteers" => "850",
      "impact_workshops" => "120",
      "impact_communities" => "15"
    }.each do |key, value|
      SiteSetting.find_or_create_by!(key: key) { |s| s.value = value }
    end

    @post = Post.find_or_create_by!(slug: "welcome") do |p|
      p.title = "Welcome to OpenMind Projects"
      p.summary = "Our first post."
      p.body = "Hello world."
      p.category = "news"
      p.status = "published"
      p.published_at = 1.day.ago
    end
  end

  # ── Static pages ──

  test "GET / (home) renders 200" do
    get root_path
    assert_response :success
    assert_select "h1"
  end

  test "GET /about renders 200" do
    get about_path
    assert_response :success
    assert_select "h1", /OpenMind Projects/
  end

  test "GET /volunteer renders 200" do
    get volunteer_path
    assert_response :success
  end

  test "GET /research-development renders 200" do
    get research_development_path
    assert_response :success
  end

  # ── Projects ──

  test "GET /projects renders 200" do
    get projects_path
    assert_response :success
    assert_select ".program-card"
  end

  test "GET /projects/:slug renders 200" do
    get project_path(@project.slug)
    assert_response :success
    assert_select "h1", @project.title
  end

  test "GET /projects with category filter renders 200" do
    get projects_path(category: "teaching")
    assert_response :success
  end

  # ── Destinations ──

  test "GET /destinations renders 200" do
    get destinations_path
    assert_response :success
  end

  test "GET /destinations/:slug renders 200" do
    get destination_path(@thailand.slug)
    assert_response :success
  end

  # ── News ──

  test "GET /news renders 200" do
    get news_index_path
    assert_response :success
  end

  test "GET /news/:slug renders 200" do
    get news_path(@post.slug)
    assert_response :success
    assert_select "h1", @post.title
  end

  # ── Application form ──

  test "GET /apply/new renders 200" do
    get new_application_path
    assert_response :success
    assert_select "form"
  end

  # ── Contact form ──

  test "GET /contact/new renders 200" do
    get new_contact_path
    assert_response :success
  end

  # ── Donate redirect ──

  test "GET /donate redirects to fundhub" do
    get donate_path
    assert_response :redirect
    assert_redirected_to "https://fundhub.openskills.dev/"
  end

  # ── Health check ──

  test "GET /up returns 200" do
    get rails_health_check_path
    assert_response :success
  end

  # ── Analytics endpoint ──

  test "POST /analytics/track returns 204" do
    post "/analytics/track", params: {
      event_type: "page_view",
      page_path: "/",
      session_id: "test-session-123"
    }, as: :json
    assert_response :no_content
  end

  # ── Layout elements ──

  test "navbar renders on every page with all links" do
    get root_path
    assert_select "nav.navbar"
    assert_select ".navbar__link", minimum: 2               # About Us, R&D
    assert_select ".navbar__dropdown", minimum: 1            # Volunteering dropdown
    assert_select ".navbar__dropdown-item", minimum: 3       # What we do, Where we work, Who volunteers
  end

  test "footer renders on every page" do
    get root_path
    assert_select "footer.footer"
  end
end
