class SeedHardcodedContentSettings < ActiveRecord::Migration[8.1]
  def up
    # Text settings that were previously hardcoded in ERB view partials.
    # These are now admin-editable via SiteSetting CRUD.
    settings = {
      # Navbar mega-menu descriptions
      "navbar_whatwedo_desc" => "We empower students, especially those with disabilities, with 21st-century skills for brighter futures through IT, programming, and English training, along with mentorship and coaching.",
      "navbar_wherewework_desc" => "Make a lasting impact in Southeast Asia. Volunteer opportunities await in Thailand, Laos, and Nepal, where you can contribute to local communities and immerse yourself in unique cultures.",
      "navbar_whovolunteers_desc" => "We welcome you to volunteer whether you're on a career break, holiday, gap year, family traveling, retired, or seeking an interesting internship. We offer meaningful volunteering for you in Southeast Asia.",

      # Navbar mega-menu images (fallback URLs until Active Storage attachments are uploaded)
      "navbar_whatwedo_image" => "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/Laos-village-girl2-scaled-qt9scq8octyj90f59fb9o18hh405wftukfkfe0eu88.jpg",
      "navbar_wherewework_image" => "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/272390-P5JPWJ-124-qy09yi905f0vdcqadwtc3490q2yfuj0fk3g42m1jt4.jpg",
      "navbar_whovolunteers_image" => "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/Babyboomer-volunteers-qtno6ssksufnh5tplixw56run0kv9y44xs8g92tdsg.jpg",

      # Pillar cards
      "pillar_education_image" => "https://openmindprojects.org/wp-content/uploads/2024/08/openmindprojects-training-center-scaled-e1724850364350.jpg",
      "pillar_education_title" => "Educational &amp; Cross-cultural Training",
      "pillar_education_body" => "Volunteers. Help and Train Youth and Adults\n\nVolunteer with OpenmindProjects. Help disadvantaged youth in Southeast Asia. Gain cross-cultural skills and contribute to our educational projects. Create a positive impact for others while you also learn and grow!",
      "pillar_education_link" => "/projects/computer-training",

      "pillar_development_image" => "https://openmindprojects.org/wp-content/uploads/2024/08/volunteer-laos-ecotourism5.jpg",
      "pillar_development_title" => "Upskill &amp; Development for Local People",
      "pillar_development_body" => "We address educational and employment gaps faced by disadvantaged youth in Southeast Asia. We provide English, technology and job skills training, and mentorships. We want to contribute to a more equitable society where underprivileged young people also can succeed.",
      "pillar_development_link" => "/projects/computer-training",

      "pillar_research_image" => "https://openmindprojects.org/wp-content/uploads/2024/08/disable-learn-codeing-scaled.jpg",
      "pillar_research_title" => "Research &amp; Development",
      "pillar_research_body" => "We are dedicated to empowering disadvantaged youth through technology, English and job skills development. We look for passionate people to help us and contribute expertise and support to our development work. We focus on creating innovative solutions to help local people through education and the access to it.",
      "pillar_research_link" => "/research-development",

      # Hub row
      "hub_title" => "Chonburi Hub is Calling",
      "hub_description" => "Get up to 100,000 THB in funding per project for skill development camps.",
      "hub_link" => "https://sendimpact.com/?ff_landing=31",

      # About page fallback images
      "about_hero_bg_image" => "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-makenew-friends14.jpg",
      "about_founders_image" => "https://openmindprojects.org/wp-content/uploads/2024/09/1openmindprojecs-co-founder-1024x1024-1.jpg"
    }

    settings.each do |key, value|
      execute <<~SQL
        INSERT INTO site_settings (key, value, value_type, created_at, updated_at)
        VALUES (#{connection.quote(key)}, #{connection.quote(value)}, 'string', NOW(), NOW())
        ON CONFLICT (key) DO NOTHING;
      SQL
    end

    # Hub carousel images as JSON
    hub_images = [
      { "url" => "https://openmindprojects.org/wp-content/uploads/2026/04/2.jpg-1024x1024.jpeg", "alt" => "Google Data center" },
      { "url" => "https://openmindprojects.org/wp-content/uploads/2026/04/13-1024x1024.jpg", "alt" => "Skill development camp" },
      { "url" => "https://openmindprojects.org/wp-content/uploads/2026/04/1-1024x1024.jpg", "alt" => "Active learning" },
      { "url" => "https://openmindprojects.org/wp-content/uploads/2026/04/11-1024x1024.jpg", "alt" => "Community workshop" },
      { "url" => "https://openmindprojects.org/wp-content/uploads/2026/04/9-1024x1024.jpg", "alt" => "Student training" },
      { "url" => "https://openmindprojects.org/wp-content/uploads/2026/04/8-1024x1024.jpg", "alt" => "Volunteer with students" }
    ].to_json

    execute <<~SQL
      INSERT INTO site_settings (key, value, value_type, created_at, updated_at)
      VALUES ('hub_images', #{connection.quote(hub_images)}, 'json', NOW(), NOW())
      ON CONFLICT (key) DO NOTHING;
    SQL
  end

  def down
    keys = %w[
      navbar_whatwedo_desc navbar_wherewework_desc navbar_whovolunteers_desc
      navbar_whatwedo_image navbar_wherewework_image navbar_whovolunteers_image
      pillar_education_image pillar_education_title pillar_education_body pillar_education_link
      pillar_development_image pillar_development_title pillar_development_body pillar_development_link
      pillar_research_image pillar_research_title pillar_research_body pillar_research_link
      hub_title hub_description hub_link hub_images
      about_hero_bg_image about_founders_image
    ]
    execute "DELETE FROM site_settings WHERE key IN (#{keys.map { |k| connection.quote(k) }.join(', ')})"
  end
end
