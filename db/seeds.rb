# db/seeds.rb - Seed data from openmindprojects.org content

puts "Seeding destinations..."
destinations = {
  thailand: Destination.find_or_create_by!(slug: "thailand") do |d|
    d.name = "Thailand"
    d.country_code = "TH"
    d.summary = "Volunteer in Thailand and help disadvantaged communities through education and technology training."
    d.latitude = 13.7563
    d.longitude = 100.5018
    d.position = 0
  end,
  laos: Destination.find_or_create_by!(slug: "laos") do |d|
    d.name = "Laos"
    d.country_code = "LA"
    d.summary = "Make a lasting impact in Laos. Contribute to local communities and immerse yourself in unique cultures."
    d.latitude = 17.9757
    d.longitude = 102.6331
    d.position = 1
  end,
  nepal: Destination.find_or_create_by!(slug: "nepal") do |d|
    d.name = "Nepal"
    d.country_code = "NP"
    d.summary = "Teach English in Nepal. Help with conservation and eco-tourism while experiencing Himalayan culture."
    d.latitude = 27.7172
    d.longitude = 85.3240
    d.position = 2
  end
}
puts "  Created #{Destination.count} destinations"

puts "Seeding projects..."
projects = [
  {
    title: "Fulbright ETA Internships: Bridge the Gap Beyond the Classroom",
    slug: "flta",
    category: "education",
    summary: "Bridge the gap beyond the classroom with a Fulbright English Teaching Assistantship internship.",
    description: "Join our partnership with the Fulbright program to bring English language education to underserved communities. Work alongside local teachers and make a real difference in students' lives.",
    destination: destinations[:thailand],
    position: 0
  },
  {
    title: "Construction Volunteer Project in Thailand",
    slug: "free-construction-volunteer-thailand",
    category: "construction",
    summary: "Help build and improve educational facilities for disadvantaged communities in Thailand.",
    description: "Contribute your hands-on skills to construction projects that directly benefit local schools and community centers. No previous construction experience required.",
    destination: destinations[:thailand],
    position: 1
  },
  {
    title: "Teach English in Nepal",
    slug: "teach-english-nepal",
    category: "teaching",
    summary: "Teach English in Nepal while helping with conservation and eco-tourism projects.",
    description: "Experience life in Nepal while teaching English to local communities. Combine your teaching with conservation efforts and eco-tourism initiatives in one of the world's most stunning locations.",
    destination: destinations[:nepal],
    position: 2
  },
  {
    title: "Volunteer in the Thailand-Myanmar Border Mountains",
    slug: "volunteer-burma-migrants",
    category: "education",
    summary: "Support migrant communities along the Thailand-Myanmar border through education and skills training.",
    description: "Work with displaced communities in the border mountain region, providing essential educational support and skills training to families who need it most.",
    destination: destinations[:thailand],
    position: 3
  },
  {
    title: "Volunteer at Learning Camps in Thailand",
    slug: "learning-camp-thailand",
    category: "education",
    summary: "Run active learning camps that combine education, creativity, and fun for Thai youth.",
    description: "Help organize and run engaging learning camps that combine 21st-century skills with creative activities. Get up to 100,000 THB in funding per project for skill development camps.",
    destination: destinations[:thailand],
    position: 4
  },
  {
    title: "Volunteer for IT Training and Development",
    slug: "computer-training",
    category: "it_training",
    summary: "Teach coding, digital literacy, and IT skills to disadvantaged youth in Southeast Asia.",
    description: "Share your tech skills with eager learners. From basic digital literacy to programming and web development, help bridge the digital divide in rural Southeast Asia.",
    destination: destinations[:thailand],
    position: 5
  },
  {
    title: "Teaching Volunteer Opportunities in Thailand",
    slug: "teaching-volunteer",
    category: "teaching",
    summary: "Teach English, computer skills, and more to Thai students in rural communities.",
    description: "Join our teaching volunteer program in Thailand. Work in local schools and community centers, teaching English, computer skills, and other subjects to students of all ages.",
    destination: destinations[:thailand],
    position: 6
  }
]

projects.each do |attrs|
  Project.find_or_create_by!(slug: attrs[:slug]) do |p|
    p.assign_attributes(attrs)
  end
end
puts "  Created #{Project.count} projects"

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

puts "\nSeeding complete!"
