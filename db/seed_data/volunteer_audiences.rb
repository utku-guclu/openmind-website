# Seed data for VolunteerAudience records. Loaded by db/seeds.rb.
# Stored as a Ruby array of hashes; the content JSON column receives the
# variable-length lists (benefits, journey, gallery, faqs, etc).

VOLUNTEER_AUDIENCES_SEED = [
  {
    slug: "retired",
    name: "Retired",
    title: "Make a Difference in Retirement",
    subtitle: "Share your lifetime of expertise with communities in Southeast Asia.",
    intro: "Find renewed purpose by volunteering abroad. Share your professional experience while immersing yourself in vibrant local cultures across Thailand, Laos, and Nepal.",
    hero_image: "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/Babyboomer-volunteers-qtno6ssksufnh5tplixw56run0kv9y44xs8g92tdsg.jpg",
    icon: "ph-tree-palm",
    duration: "Flexible — 2 weeks to several months",
    cta_text: "Apply Today",
    position: 0,
    content: {
      "benefits" => [
        { "icon" => "ph-graduation-cap",     "title" => "Real Impact",            "text" => "Make a tangible difference in children's futures through skill-building." },
        { "icon" => "ph-chalkboard-teacher", "title" => "Share Your Expertise",   "text" => "Mentor in English, IT, business, or your professional craft." },
        { "icon" => "ph-globe-hemisphere-east", "title" => "Cultural Immersion", "text" => "Live alongside local families and experience authentic Southeast Asia." },
        { "icon" => "ph-lifebuoy",           "title" => "Comprehensive Support",  "text" => "Handbook, online orientation, on-site assistance throughout your stay." },
        { "icon" => "ph-tag",                "title" => "Affordable Fees",        "text" => "Nonprofit pricing — your contribution funds our mission." },
        { "icon" => "ph-shuffle",            "title" => "Flexible Roles",         "text" => "Teaching, mentoring, camp support, research — choose what fits you." }
      ],
      "journey" => [
        { "step" => "1", "title" => "Pre-departure",       "text" => "Online guidance and a detailed handbook to prepare you." },
        { "step" => "2", "title" => "In-country welcome", "text" => "Local team meets you, orientation and cross-cultural workshop." },
        { "step" => "3", "title" => "Live & serve",        "text" => "Accommodation with private room and meals included." },
        { "step" => "4", "title" => "Certificate",         "text" => "Receive a certificate of completion when you finish." }
      ]
    }
  },

  {
    slug: "gap_year",
    name: "Gap Year",
    title: "A Gap Year That Changes Lives — Yours Included",
    subtitle: "Make a difference and gain valuable experience before university or career.",
    intro: "Pursue a meaningful gap year by volunteering with disadvantaged communities in Southeast Asia. Build skills, gain perspective, and make memories that last a lifetime.",
    hero_image: "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/Volunteer-trekking-pumkpumpkin-farm-qm77x09pej61aotcs8m22qrvjsfvavgo08yc5qq6kg.jpg",
    icon: "ph-airplane-takeoff",
    duration: "Typically 1–6 months",
    cta_text: "Start Your Gap Year",
    position: 1,
    content: {
      "benefits" => [
        { "icon" => "ph-heart",        "title" => "Purpose-driven",     "text" => "Contribute to a nonprofit dedicated to disadvantaged youth." },
        { "icon" => "ph-shuffle",      "title" => "Flexible Roles",     "text" => "Teach English or IT, run social media, or share unique talents." },
        { "icon" => "ph-medal",        "title" => "Academic Credit",    "text" => "May be eligible for credit at your university." },
        { "icon" => "ph-users-three",  "title" => "Lifelong Network",   "text" => "Build deep connections with volunteers and locals." },
        { "icon" => "ph-book-open",    "title" => "Detailed Handbook",  "text" => "Teaching tips, cultural notes, and travel guidance included." },
        { "icon" => "ph-certificate",  "title" => "Reference Letter",   "text" => "Certificate or reference letter on completion." }
      ],
      "journey" => [
        { "step" => "1", "title" => "Apply",     "text" => "Tell us about your skills, interests, and goals." },
        { "step" => "2", "title" => "Match",     "text" => "We pair you with a project that fits your strengths." },
        { "step" => "3", "title" => "Prepare",   "text" => "Online orientation, handbook, and travel guidance." },
        { "step" => "4", "title" => "Volunteer", "text" => "Immerse yourself in Thailand, Laos, or Nepal." }
      ]
    }
  },

  {
    slug: "internship",
    name: "Internship",
    title: "Internship Abroad That Means Something",
    subtitle: "Empowering communities through international internships.",
    intro: "Combine hands-on experience with professional development through a global impact internship at a 22-year-old Southeast Asian nonprofit. Real projects, real mentorship, real outcomes.",
    hero_image: "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/internship-qpum9thls3ji2yshyk8vftq4bw48qiyyrtvgz1e9qg.jpg",
    icon: "ph-briefcase",
    duration: "From 3 weeks — extend as you wish",
    cta_text: "Apply for an Internship",
    position: 2,
    content: {
      "benefits" => [
        { "icon" => "ph-hammer",            "title" => "Hands-on Practice",      "text" => "Apply your skills to actual community projects." },
        { "icon" => "ph-globe-hemisphere-east", "title" => "Cultural Immersion", "text" => "Live and work across Thailand, Laos, and Cambodia." },
        { "icon" => "ph-user-focus",        "title" => "Mentorship",             "text" => "Guidance from experienced staff who know the ground." },
        { "icon" => "ph-link",              "title" => "International Network",  "text" => "Connect with peers and global volunteers." },
        { "icon" => "ph-clock",             "title" => "Flexible Duration",      "text" => "Internships start from just 3 weeks." },
        { "icon" => "ph-tree-structure",    "title" => "Diverse Roles",          "text" => "Software dev, IT instruction, grant writing, M&E, comms." }
      ],
      "journey" => [
        { "step" => "1", "title" => "Choose Type",   "text" => "Select the internship track that matches your discipline." },
        { "step" => "2", "title" => "Share",         "text" => "Tell us your skills, interests, and what you want to learn." },
        { "step" => "3", "title" => "Consultation",  "text" => "Get project suggestions and book a call with us." },
        { "step" => "4", "title" => "Handbook",      "text" => "Teaching, culture, language, and travel guidance — then begin." }
      ]
    }
  },

  {
    slug: "career_break",
    name: "Career Break",
    title: "Transform Your Career Break Into a Life-Changing Adventure",
    subtitle: "Recharge with purpose while making a tangible community impact.",
    intro: "Use your career break to volunteer in Thailand with an NGO empowering disadvantaged youth. Develop leadership skills, broaden perspective, and return refreshed.",
    hero_image: "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/Mae-Sot-Burmese-school-volunteer-qsl91fb6tn5kgaybi45m1l5g73qd9d1ymqtbifsdis.jpg",
    icon: "ph-coffee",
    duration: "A week to several months — your choice",
    cta_text: "Plan Your Career Break",
    position: 3,
    content: {
      "benefits" => [
        { "icon" => "ph-target",            "title" => "Tangible Impact",      "text" => "Skill-share where it matters most." },
        { "icon" => "ph-clock",             "title" => "Flexible Duration",    "text" => "From one week to several months." },
        { "icon" => "ph-globe-hemisphere-east", "title" => "Authentic Immersion", "text" => "Cultural exchange beyond the tourist trail." },
        { "icon" => "ph-trend-up",          "title" => "Leadership Growth",    "text" => "Sharpen cross-cultural communication and adaptability." },
        { "icon" => "ph-headset",           "title" => "Full Support",         "text" => "Comprehensive onsite and online training." },
        { "icon" => "ph-tag",               "title" => "Affordable",           "text" => "Mission-driven, nonprofit pricing." }
      ],
      "journey" => [
        { "step" => "1", "title" => "Apply",          "text" => "Share your skills, interests, and what you want from the break." },
        { "step" => "2", "title" => "Match",          "text" => "We connect you with the right project." },
        { "step" => "3", "title" => "Discuss",        "text" => "Online call with coordinators to lock in details." },
        { "step" => "4", "title" => "Handbook & Go",  "text" => "Cultural and travel guidance — then you're on the ground." }
      ]
    }
  },

  {
    slug: "csr",
    name: "CSR / Group",
    title: "Corporate Volunteering With Real-World Impact",
    subtitle: "Custom-built programs aligning your CSR goals with community need.",
    intro: "Partner with us to give your team meaningful volunteer experiences — teaching, IT training, fundraising, and community support, scaled to your goals and timeline.",
    hero_image: "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/Corp-volunteers-qtnpzc0xqxs7s8lfwz4hbnbkr8ompv3ekisl16fb0g.jpg",
    icon: "ph-buildings",
    duration: "One day to several months — fully customizable",
    cta_text: "Apply for Free — No Registration Fee",
    position: 4,
    content: {
      "benefits" => [
        { "icon" => "ph-strategy",          "title" => "Leadership Building",  "text" => "Develop communication and problem-solving in the field." },
        { "icon" => "ph-handshake",         "title" => "Cross-cultural Skills","text" => "Adaptability that translates back to the workplace." },
        { "icon" => "ph-users-three",       "title" => "Team Cohesion",        "text" => "Shared purpose builds collaboration that sticks." },
        { "icon" => "ph-heart",             "title" => "Direct Impact",        "text" => "Help disadvantaged students gain real-world skills." },
        { "icon" => "ph-star",              "title" => "Brand Reputation",     "text" => "Authentic CSR story your stakeholders will value." },
        { "icon" => "ph-slider-horizontal", "title" => "Flexible Format",      "text" => "From single-day workshops to multi-month residencies." }
      ],
      "journey" => [
        { "step" => "1", "title" => "Choose Format", "text" => "Select volunteer or internship application type." },
        { "step" => "2", "title" => "Share Goals",   "text" => "Tell us about your team's skills and CSR objectives." },
        { "step" => "3", "title" => "Consult",       "text" => "Receive project suggestions; book a call to refine." },
        { "step" => "4", "title" => "Deploy",        "text" => "Comprehensive handbook with full operational guidance." }
      ]
    }
  },

  {
    slug: "family",
    name: "Family",
    title: "Family Volunteering",
    subtitle: "Family Volunteering in Thailand: Create Lasting Memories with OpenmindProjects",
    intro: "Imagine exploring the vibrant culture of Thailand with your family while making a real difference in the lives of local children. With OpenmindProjects, your family can embark on a meaningful adventure, teaching English and IT skills while creating unforgettable memories together.",
    hero_image: "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/family-volunteer-kids-trip15-qtnpzc0xqxs7s8lfwz4hbnbkr8ompv3ekisl16fb0g.jpg",
    hero_video_id: "1XgHBR_I6Yw",
    icon: "ph-users-four",
    duration: "Flexible — from a week to multiple months",
    cta_text: "Apply Today!",
    podcast_url: "https://api.soundcloud.com/tracks/1948466235",
    position: 5,
    content: {
      "benefits" => [
        { "icon" => "ph-heart",             "title" => "Strengthen Family Bonds", "text" => "Share teaching, learn from another culture, and grow closer as a unit." },
        { "icon" => "ph-globe-hemisphere-east", "title" => "Authentic Immersion", "text" => "Live among Thai families; explore temples, markets, and natural wonders." },
        { "icon" => "ph-tag",               "title" => "Children Free",           "text" => "Affordable nonprofit pricing — kids volunteer at no cost." },
        { "icon" => "ph-handshake",         "title" => "Real Community Impact",   "text" => "Work directly with schools, students, and local teachers." }
      ],
      "journey" => [
        { "step" => "1", "title" => "Apply",     "text" => "Tell us about your family — ages, skills, interests, dates." },
        { "step" => "2", "title" => "Match",     "text" => "We pair you with a school or community partner that fits." },
        { "step" => "3", "title" => "Prepare",   "text" => "Receive a handbook with cultural, language, and travel guidance." },
        { "step" => "4", "title" => "Volunteer", "text" => "Land in Thailand, meet your hosts, and start the adventure." }
      ],
      "intro_sections" => [
        { "heading" => "Make a Difference Together",
          "body" => "Join us in Northern or Southern Thailand, where lush mountains meet friendly villages and ancient temples stand alongside bustling markets. Here, you'll have the opportunity to connect with local communities and inspire young learners." }
      ],
      "activity_intro" => "Our family volunteer program focuses on empowering students through education. You'll engage in activities like:",
      "activity_bullets" => [
        "Leading interactive English lessons with games, songs, and role-playing.",
        "Helping students create presentations and videos to build their confidence in English.",
        "Guiding students to explore the internet and learn essential IT skills, including coding.",
        "Participating in cultural exchange activities and making new friends in the community."
      ],
      "bond_sections" => [
        { "heading" => "Inspire and Be Inspired",
          "body" => "Volunteering with OpenmindProjects is a two-way street. While you share your knowledge and enthusiasm, you'll also gain incredible insights into Thai culture and create bonds with the local community.\n\nExperience the warmth of Thai hospitality, explore stunning natural landscapes, and immerse yourselves in a way of life that will broaden your perspectives." },
        { "heading" => "Strengthen Family Bonds",
          "body" => "Family volunteering offers a unique opportunity to grow closer as a unit. Share the joy of teaching, learn from another culture, and create bonds that will last a lifetime. Family volunteering with OpenmindProjects is an investment in your family's future." },
        { "heading" => "Immerse in Thai Culture",
          "body" => "Beyond volunteering, you'll have ample time to explore the wonders of Thailand. Visit ancient temples, wander through vibrant markets, sample delicious local cuisine, and discover hidden gems off the beaten path." }
      ],
      "podcast_deepdive" => {
        "title" => "Family Volunteering Deep-dive",
        "image" => "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/volunteer-family-1.jpg-qwi842nvbj9g32w4pq5illmocmmhaincun6c6oinpk.webp",
        "description" => "Want to make a difference and create lasting family memories? 🎧 Tune in to learn how you can volunteer in Thailand with OpenmindProjects! 🇹🇭 #FamilyVolunteering #ThailandAdventure"
      },
      "gallery_images" => [
        "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-vacation2.jpg",
        "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteering-village-1024x1024-1.jpg",
        "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-trip1.jpg",
        "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-culture-tour-trip15.jpg",
        "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-teaching3.jpg",
        "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-teaching2.jpg",
        "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-makenew-friends14.jpg",
        "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-makenew-friends4.jpg",
        "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-teaching4.jpg",
        "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-culture-tour-trip15-1.jpg",
        "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-farming-trip2.jpg",
        "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-kids-make-friends-1.jpg",
        "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-makenew-friends1.jpg",
        "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-kids-trip15.jpg",
        "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-kids-make-friends.jpg",
        "https://openmindprojects.org/wp-content/uploads/2024/11/Frederickson-family.webp"
      ],
      "video_playlist" => [
        { "title" => "Volunteer Abroad as a Family — Georgina, Adria and their daughters", "youtube_id" => "W1yJxY52E28", "duration" => "2:01" },
        { "title" => "Lacoste family: Family Volunteer Opportunities Abroad",              "youtube_id" => "1XgHBR_I6Yw", "duration" => "4:45" },
        { "title" => "A True Story — Alumni James",                                        "youtube_id" => "3AfDLor6AM8", "duration" => "2:58" }
      ],
      "faqs" => [
        { "question" => "What kind of family volunteer opportunities does OpenmindProjects offer?",
          "answer"   => "We offer families the chance to teach English and IT skills to students in Thailand and Southeast Asia. Your family can lead interactive English lessons, help students create presentations and videos, guide IT exploration including coding, and join local activities." },
        { "question" => "What are the benefits of family volunteering abroad with us?",
          "answer"   => "Inspire local students and experience another culture, create lasting memories and strengthen family bonds, work closely with the community, and enjoy affordable volunteering — children volunteer for free." },
        { "question" => "What skills or qualifications do I need to volunteer?",
          "answer"   => "A passion for teaching and working with children. Conversational English is important." },
        { "question" => "Is there an age limit for children to participate?",
          "answer"   => "Families with children of all ages are welcome. Children inspire local kids and volunteering builds empathy and global citizenship." },
        { "question" => "How long can families volunteer for?",
          "answer"   => "Duration is flexible — from a week to several months. We'll discuss and accommodate your time commitment." },
        { "question" => "How much does it cost to volunteer with OpenmindProjects?",
          "answer"   => "We're a nonprofit. Children volunteer for free. Families cover accommodation and living expenses; at our Northeastern Thailand center, costs start as low as $19/day for a private room with lunch and dinner included on weekdays." },
        { "question" => "How can I contact you to discuss opportunities?",
          "answer"   => "Email us or use the application form on this site. We're happy to meet online or by phone to discuss your family's interests and availability." },
        { "question" => "Are there testimonials from previous volunteer families?",
          "answer"   => "Yes — read stories on this site, and we can connect you with previous volunteer families on request." }
      ]
    }
  }
].freeze
