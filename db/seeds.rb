# db/seeds.rb - Seed data from openmindprojects.org content

require_relative "seed_data/volunteer_audiences"

puts "Seeding destinations..."
destination_data = [
  {
    slug: "thailand",
    name: "Thailand",
    country_code: "TH",
    summary: "Volunteer in Thailand and help disadvantaged communities through education and technology training.",
    latitude: 13.7563,
    longitude: 100.5018,
    position: 0,
    status: "active",
    hero_image_url: "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-kids-trip15.jpg",
    activities: ["Teach English", "Learning Camp", "IT Training", "Conservation", "Social Media", "Online Marketing", "Ethnic Minority", "Migrant"],
    locations: [
      { "name" => "Nong Khai",  "region" => "Northeast Thailand",  "summary" => "Our primary hub — schools, training centers, and the volunteer base." },
      { "name" => "Mae Sot",    "region" => "Tak Province",        "summary" => "Border town supporting Burmese migrant communities and schools." },
      { "name" => "Umphang",    "region" => "Tak Province",        "summary" => "Remote mountain district near the Myanmar border." },
      { "name" => "Krabi",      "region" => "Southern Thailand",   "summary" => "Coastal community programs combining education and eco-tourism." }
    ]
  },
  {
    slug: "laos",
    name: "Laos",
    country_code: "LA",
    summary: "Make a lasting impact in Laos. Contribute to local communities and immerse yourself in unique cultures.",
    latitude: 17.9757,
    longitude: 102.6331,
    position: 1,
    status: "active",
    hero_image_url: "https://openmindprojects.org/wp-content/uploads/2024/11/volunteer-in-laos.jpg",
    activities: ["Teach English", "Eco Tourism"],
    locations: [
      { "name" => "Nalong",            "region" => "Vientiane Province", "summary" => "Rural village partner for IT training and learning camps." },
      { "name" => "Phou Khao Khouay",  "region" => "National Park",      "summary" => "Eco-tourism and conservation collaboration site." }
    ]
  },
  {
    slug: "nepal",
    name: "Nepal",
    country_code: "NP",
    summary: "Teach English in Nepal. Help with conservation and eco-tourism while experiencing Himalayan culture.",
    latitude: 27.7172,
    longitude: 85.3240,
    position: 2,
    status: "active",
    hero_image_url: "https://openmindprojects.org/wp-content/uploads/2024/11/kids-nepal2-scaled.jpg",
    activities: ["Teach English", "Conservation", "Eco Tourism", "Social Media"],
    locations: [
      { "name" => "Chitwan", "region" => "Central Nepal", "summary" => "Lowland community partner for English teaching and conservation." }
    ]
  },
  {
    slug: "cambodia",
    name: "Cambodia",
    country_code: "KH",
    summary: "Future programs in Cambodia — community partnerships are being established.",
    latitude: 11.5564,
    longitude: 104.9282,
    position: 3,
    status: "coming_soon",
    hero_image_url: nil,
    activities: [],
    locations: []
  }
]

destinations = {}
destination_data.each do |attrs|
  locs = attrs.delete(:locations)
  activities = attrs.delete(:activities)
  dest = Destination.find_or_initialize_by(slug: attrs[:slug])
  dest.assign_attributes(attrs)
  # Wipe legacy meta.locations payload — now lives in the locations table
  dest.meta = (dest.meta || {}).except("locations") if dest.meta.is_a?(Hash)
  dest.activities = activities if activities
  dest.save!
  destinations[attrs[:slug].to_sym] = dest

  locs.each_with_index do |loc_attrs, idx|
    loc_slug = "#{dest.slug}-#{loc_attrs['name']}".parameterize
    loc = Location.find_or_initialize_by(slug: loc_slug)
    loc.assign_attributes(
      name: loc_attrs["name"],
      region: loc_attrs["region"],
      summary: loc_attrs["summary"],
      destination: dest,
      status: "active",
      position: idx
    )
    loc.save!
  end
end
puts "  Created/updated #{Destination.count} destinations (#{Destination.active.count} active), #{Location.count} locations"

puts "Seeding projects..."

# Build a quick lookup of locations by destination + name
locations = Location.includes(:destination).index_by { |l| "#{l.destination.slug}/#{l.name}" }

projects = [
  {
    title: "Fulbright ETA Internships: Bridge the Gap Beyond the Classroom",
    slug: "flta",
    category: "english",
    summary: "Bridge the gap beyond the classroom with a Fulbright English Teaching Assistantship internship.",
    description: "Join our partnership with the Fulbright program to bring English language education to underserved communities. Work alongside local teachers and make a real difference in students' lives.",
    destination: destinations[:thailand],
    location: locations["thailand/Nong Khai"],
    position: 0
  },
  {
    title: "Construction Volunteer Project in Thailand",
    slug: "free-construction-volunteer-thailand",
    category: "construction",
    summary: "Help build and improve educational facilities for disadvantaged communities in Thailand.",
    description: "Contribute your hands-on skills to construction projects that directly benefit local schools and community centers. No previous construction experience required.",
    destination: destinations[:thailand],
    location: locations["thailand/Nong Khai"],
    position: 1
  },
  {
    title: "Teach English in Nepal",
    slug: "teach-english-nepal",
    category: "english",
    summary: "Teach English in Nepal while helping with conservation and eco-tourism projects.",
    description: "Experience life in Nepal while teaching English to local communities. Combine your teaching with conservation efforts and eco-tourism initiatives in one of the world's most stunning locations.",
    destination: destinations[:nepal],
    location: locations["nepal/Chitwan"],
    position: 2
  },
  {
    title: "Volunteer in the Thailand-Myanmar Border Mountains",
    slug: "volunteer-burma-migrants",
    category: "english",
    summary: "Support migrant communities along the Thailand-Myanmar border through education and skills training.",
    description: "Work with displaced communities in the border mountain region, providing essential educational support and skills training to families who need it most.",
    destination: destinations[:thailand],
    location: locations["thailand/Mae Sot"],
    position: 3
  },
  {
    title: "Volunteer at Learning Camps in Thailand",
    slug: "learning-camp-thailand",
    category: "camps",
    summary: "Run active learning camps that combine education, creativity, and fun for Thai youth.",
    description: "Help organize and run engaging learning camps that combine 21st-century skills with creative activities. Get up to 100,000 THB in funding per project for skill development camps.",
    destination: destinations[:thailand],
    location: locations["thailand/Nong Khai"],
    position: 4
  },
  {
    title: "Volunteer for IT Training and Development",
    slug: "computer-training",
    category: "it",
    summary: "Teach coding, digital literacy, and IT skills to disadvantaged youth in Southeast Asia.",
    description: "Share your tech skills with eager learners. From basic digital literacy to programming and web development, help bridge the digital divide in rural Southeast Asia.",
    destination: destinations[:thailand],
    location: locations["thailand/Nong Khai"],
    position: 5
  },
  {
    title: "Teaching Volunteer Opportunities in Thailand",
    slug: "teaching-volunteer",
    category: "english",
    summary: "Teach English, computer skills, and more to Thai students in rural communities.",
    description: "Join our teaching volunteer program in Thailand. Work in local schools and community centers, teaching English, computer skills, and other subjects to students of all ages.",
    destination: destinations[:thailand],
    location: locations["thailand/Krabi"],
    position: 6
  },
  {
    title: "Train the Trainer: Empowering Local Educators",
    slug: "train-the-trainer",
    category: "ttt",
    summary: "Build long-term capacity by coaching local teachers in modern, learner-centered methods.",
    description: "Our Train-the-Trainer program multiplies your impact. Work side-by-side with local educators to introduce 21st-century pedagogy, active-learning techniques, and digital classroom tools. The skills you transfer keep delivering value long after you've left.",
    destination: destinations[:thailand],
    location: locations["thailand/Nong Khai"],
    position: 7
  },
  {
    title: "Responsible Voluntourism in Southeast Asia",
    slug: "responsible-voluntourism",
    category: "voluntourism",
    summary: "Combine meaningful service with ethical, low-impact travel in Thailand, Laos, and Nepal.",
    description: "For travelers who want their journey to leave a positive footprint. Short-format placements (1–3 weeks) that pair authentic cultural immersion with hands-on contribution — designed to support local communities without disrupting them.",
    destination: destinations[:thailand],
    location: locations["thailand/Umphang"],
    position: 8
  }
]

projects.each do |attrs|
  project = Project.find_or_initialize_by(slug: attrs[:slug])
  project.assign_attributes(attrs)
  project.save!
end
puts "  Created/updated #{Project.count} projects"

puts "Seeding partners..."
[
  { name: "UNESCO", tier: "featured", position: 0 },
  { name: "Google", tier: "featured", position: 1 },
  { name: "ChangeX", tier: "featured", position: 2 },
  { name: "GlobalGiving", tier: "featured", position: 3 },
  { name: "CNN", tier: "featured", position: 4 },
  { name: "Riot Games Social Impact Fund", tier: "featured", position: 5 },
  { name: "Great Nonprofits", tier: "standard", position: 6 },
  { name: "Rotary Club of San Jose", tier: "standard", position: 7 },
  { name: "Bangkok Post", tier: "standard", position: 8 },
  { name: "Lonely Planet", tier: "standard", position: 9 },
  { name: "TechSoup", tier: "standard", position: 10 }
].each do |attrs|
  Partner.find_or_create_by!(name: attrs[:name]) do |p|
    p.assign_attributes(attrs)
  end
end
puts "  Created #{Partner.count} partners"

puts "Seeding site settings..."
{
  "hero_title" => "Fight Poverty",
  "hero_subtitle" => "Ethical and responsible volunteer work empowering impoverished youth and their parents in Southeast Asia.",
  "impact_years" => "20",
  "impact_students" => "5000",
  "impact_countries" => "3",
  "impact_volunteers" => "850",
  "impact_workshops" => "120",
  "impact_communities" => "15",
  "org_vision" => "We envision a future of equal opportunities in which young people, no matter their backgrounds, have hope, inspiration and confidence to realize their dreams.",
  "org_mission" => "Our mission is to empower disadvantaged youth in rural Southeast Asia through active learning, bridging the digital and educational divide, and fostering confidence for a brighter future.",
  "org_founded" => "2001",
  "org_registration" => "Registered Nonprofit: 2526/2 Thailand EST. 2001"
}.each do |key, value|
  SiteSetting.find_or_create_by!(key: key) do |s|
    s.value = value
  end
end
puts "  Created #{SiteSetting.count} site settings"

puts "Seeding admin user..."
AdminUser.find_or_create_by!(email: "admin@openmindprojects.org") do |u|
  u.name = "Admin"
  u.password = "changeme123"
  u.role = "superadmin"
end
puts "  Admin user: admin@openmindprojects.org / changeme123"

puts "Seeding team members..."
TeamMember.destroy_all
[
  {
    name: "Ranjan Bhandari",
    role: "coordinator, volunteer contact",
    country: "Nepal",
    department: "coordination",
    position: 0
  },
  {
    name: "Gorawan Joompaula",
    role: "coordinator, volunteer contact , Administrative officer",
    country: "Thailand",
    department: "coordination",
    position: 1
  },
  {
    name: "Pharinya (James) Auttho",
    role: "coordinator, volunteer contact",
    country: "Thailand, Laos",
    department: "coordination",
    position: 2
  },
  {
    name: "Dr. Thitichaya Boonsom (Mui)",
    role: "Projects Director, volunteer contact",
    country: "Thailand",
    department: "leadership",
    position: 3
  },
  {
    name: "Dr. Jim Brown",
    role: "advisory, volunteer contact",
    country: "United States of America",
    department: "advisory",
    position: 4
  },
  {
    name: "Sven Mauleon",
    role: "advisory, Co-funder",
    country: "Thailand, Sweden",
    department: "leadership",
    position: 5
  },
  {
    name: "Gaweechat Joompaula",
    role: "Co-funder, Projects Director",
    country: "Thailand, Cambodia, Nepal, Laos",
    department: "leadership",
    position: 6
  }
].each do |attrs|
  TeamMember.create!(attrs)
end
puts "  Created #{TeamMember.count} team members"

puts "Seeding posts..."
author = AdminUser.find_by(email: "admin@openmindprojects.org")
posts_data = [
  {
    slug: "20-years-of-impact",
    title: "Celebrating 20 Years of Educational Impact in Southeast Asia",
    summary: "From a single IT classroom in 2001 to programs across Thailand, Laos, and Nepal — looking back on two decades of community work.",
    category: "story",
    published_at: Date.parse("2026-04-12"),
    body: "<p>When we started OpenmindProjects in 2001, we had one classroom, a handful of computers, and a stubborn belief that access to skills could change a life. Twenty years on, the network has grown — but the mission hasn't shifted.</p><p>We've reached thousands of young people through IT training, English classes, learning camps, and our train-the-trainer programs. None of it would exist without our volunteers, local coordinators, and partner schools.</p><p>This anniversary year, we're refocusing on the basics: deep partnerships, high-quality teaching, and giving young people the tools to build their own futures.</p>"
  },
  {
    slug: "chonburi-hub-launch",
    title: "Chonburi Hub Now Accepting Project Submissions",
    summary: "Our new innovation hub in Chonburi is open for proposals — up to 100,000 THB available per skill-development project.",
    category: "announcement",
    published_at: Date.parse("2026-03-28"),
    body: "<p>The Chonburi Hub is officially up and running. We're funding projects that build 21st-century skills in disadvantaged communities — coding camps, English intensives, train-the-trainer workshops, and creative learning labs.</p><p>Each accepted project receives up to <strong>100,000 THB</strong> in seed funding plus access to our volunteer pool and partner network. Submissions are reviewed on a rolling basis.</p>"
  },
  {
    slug: "volunteer-spotlight-maria",
    title: "Volunteer Spotlight: Maria's Three Months in Nong Khai",
    summary: "A career-break volunteer reflects on teaching English at our Northeast Thailand hub.",
    category: "story",
    published_at: Date.parse("2026-02-15"),
    body: "<p>Maria arrived in Nong Khai expecting to teach grammar. Three months later, she was running an after-school coding club, organizing a community library, and learning to cook Isaan-style somtam from her host family.</p><p>\"I came here to give something,\" she told us before flying home. \"I ended up receiving a lot more than I gave.\"</p><p>If you're considering a career break with purpose, her story is a good starting point.</p>"
  },
  {
    slug: "cambodia-reopening-soon",
    title: "Cambodia Programs: Restart Update",
    summary: "Partnerships are reforming in Cambodia. Here's where we stand and when you can apply.",
    category: "announcement",
    published_at: Date.parse("2026-01-20"),
    body: "<p>We've been quietly rebuilding our Cambodia partnerships since late 2025. Two community sites are now confirmed, and we're targeting a formal program reopening later this year.</p><p>If you're interested in volunteering in Cambodia, register your interest through our application form — we'll reach out as placements open.</p>"
  }
]

posts_data.each do |attrs|
  post = Post.find_or_initialize_by(slug: attrs[:slug])
  post.assign_attributes(attrs.merge(status: "published", author: author))
  post.save!
end
puts "  Created #{Post.count} posts"

puts "Seeding volunteer audiences..."
VOLUNTEER_AUDIENCES_SEED.each do |attrs|
  audience = VolunteerAudience.find_or_initialize_by(slug: attrs[:slug])
  audience.assign_attributes(attrs)
  audience.save!
end
puts "  Created/updated #{VolunteerAudience.count} volunteer audiences"

puts "\nSeeding complete!"
