class VolunteerAudience
  attr_reader :slug, :name, :title, :subtitle, :intro, :hero_image, :path,
              :icon, :benefits, :journey, :cta_text, :duration

  AUDIENCES = {
    "retired" => {
      name: "Retired",
      title: "Make a Difference in Retirement",
      subtitle: "Share your lifetime of expertise with communities in Southeast Asia.",
      intro: "Find renewed purpose by volunteering abroad. Share your professional experience while immersing yourself in vibrant local cultures across Thailand, Laos, and Nepal.",
      hero_image: "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/Babyboomer-volunteers-qtno6ssksufnh5tplixw56run0kv9y44xs8g92tdsg.jpg",
      icon: "ph-tree-palm",
      duration: "Flexible — 2 weeks to several months",
      benefits: [
        { icon: "ph-graduation-cap", title: "Real Impact", text: "Make a tangible difference in children's futures through skill-building." },
        { icon: "ph-chalkboard-teacher", title: "Share Your Expertise", text: "Mentor in English, IT, business, or your professional craft." },
        { icon: "ph-globe-hemisphere-east", title: "Cultural Immersion", text: "Live alongside local families and experience authentic Southeast Asia." },
        { icon: "ph-lifebuoy", title: "Comprehensive Support", text: "Handbook, online orientation, on-site assistance throughout your stay." },
        { icon: "ph-tag", title: "Affordable Fees", text: "Nonprofit pricing — your contribution funds our mission." },
        { icon: "ph-shuffle", title: "Flexible Roles", text: "Teaching, mentoring, camp support, research — choose what fits you." }
      ],
      journey: [
        { step: "1", title: "Pre-departure", text: "Online guidance and a detailed handbook to prepare you." },
        { step: "2", title: "In-country welcome", text: "Local team meets you, orientation and cross-cultural workshop." },
        { step: "3", title: "Live & serve", text: "Accommodation with private room and meals included." },
        { step: "4", title: "Certificate", text: "Receive a certificate of completion when you finish." }
      ],
      cta_text: "Apply Today"
    },
    "gap_year" => {
      name: "Gap Year",
      title: "A Gap Year That Changes Lives — Yours Included",
      subtitle: "Make a difference and gain valuable experience before university or career.",
      intro: "Pursue a meaningful gap year by volunteering with disadvantaged communities in Southeast Asia. Build skills, gain perspective, and make memories that last a lifetime.",
      hero_image: "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/Volunteer-trekking-pumkpumpkin-farm-qm77x09pej61aotcs8m22qrvjsfvavgo08yc5qq6kg.jpg",
      icon: "ph-airplane-takeoff",
      duration: "Typically 1–6 months",
      benefits: [
        { icon: "ph-heart", title: "Purpose-driven", text: "Contribute to a nonprofit dedicated to disadvantaged youth." },
        { icon: "ph-shuffle", title: "Flexible Roles", text: "Teach English or IT, run social media, or share unique talents." },
        { icon: "ph-medal", title: "Academic Credit", text: "May be eligible for credit at your university." },
        { icon: "ph-users-three", title: "Lifelong Network", text: "Build deep connections with volunteers and locals." },
        { icon: "ph-book-open", title: "Detailed Handbook", text: "Teaching tips, cultural notes, and travel guidance included." },
        { icon: "ph-certificate", title: "Reference Letter", text: "Certificate or reference letter on completion." }
      ],
      journey: [
        { step: "1", title: "Apply", text: "Tell us about your skills, interests, and goals." },
        { step: "2", title: "Match", text: "We pair you with a project that fits your strengths." },
        { step: "3", title: "Prepare", text: "Online orientation, handbook, and travel guidance." },
        { step: "4", title: "Volunteer", text: "Immerse yourself in Thailand, Laos, or Nepal." }
      ],
      cta_text: "Start Your Gap Year"
    },
    "internship" => {
      name: "Internship",
      title: "Internship Abroad That Means Something",
      subtitle: "Empowering communities through international internships.",
      intro: "Combine hands-on experience with professional development through a global impact internship at a 22-year-old Southeast Asian nonprofit. Real projects, real mentorship, real outcomes.",
      hero_image: "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/internship-qpum9thls3ji2yshyk8vftq4bw48qiyyrtvgz1e9qg.jpg",
      icon: "ph-briefcase",
      duration: "From 3 weeks — extend as you wish",
      benefits: [
        { icon: "ph-hammer", title: "Hands-on Practice", text: "Apply your skills to actual community projects." },
        { icon: "ph-globe-hemisphere-east", title: "Cultural Immersion", text: "Live and work across Thailand, Laos, and Cambodia." },
        { icon: "ph-user-focus", title: "Mentorship", text: "Guidance from experienced staff who know the ground." },
        { icon: "ph-link", title: "International Network", text: "Connect with peers and global volunteers." },
        { icon: "ph-clock", title: "Flexible Duration", text: "Internships start from just 3 weeks." },
        { icon: "ph-tree-structure", title: "Diverse Roles", text: "Software dev, IT instruction, grant writing, M&E, comms." }
      ],
      journey: [
        { step: "1", title: "Choose Type", text: "Select the internship track that matches your discipline." },
        { step: "2", title: "Share", text: "Tell us your skills, interests, and what you want to learn." },
        { step: "3", title: "Consultation", text: "Get project suggestions and book a call with us." },
        { step: "4", title: "Handbook", text: "Teaching, culture, language, and travel guidance — then begin." }
      ],
      cta_text: "Apply for an Internship"
    },
    "career_break" => {
      name: "Career Break",
      title: "Transform Your Career Break Into a Life-Changing Adventure",
      subtitle: "Recharge with purpose while making a tangible community impact.",
      intro: "Use your career break to volunteer in Thailand with an NGO empowering disadvantaged youth. Develop leadership skills, broaden perspective, and return refreshed.",
      hero_image: "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/Mae-Sot-Burmese-school-volunteer-qsl91fb6tn5kgaybi45m1l5g73qd9d1ymqtbifsdis.jpg",
      icon: "ph-coffee",
      duration: "A week to several months — your choice",
      benefits: [
        { icon: "ph-target", title: "Tangible Impact", text: "Skill-share where it matters most." },
        { icon: "ph-clock", title: "Flexible Duration", text: "From one week to several months." },
        { icon: "ph-globe-hemisphere-east", title: "Authentic Immersion", text: "Cultural exchange beyond the tourist trail." },
        { icon: "ph-trend-up", title: "Leadership Growth", text: "Sharpen cross-cultural communication and adaptability." },
        { icon: "ph-headset", title: "Full Support", text: "Comprehensive onsite and online training." },
        { icon: "ph-tag", title: "Affordable", text: "Mission-driven, nonprofit pricing." }
      ],
      journey: [
        { step: "1", title: "Apply", text: "Share your skills, interests, and what you want from the break." },
        { step: "2", title: "Match", text: "We connect you with the right project." },
        { step: "3", title: "Discuss", text: "Online call with coordinators to lock in details." },
        { step: "4", title: "Handbook & Go", text: "Cultural and travel guidance — then you're on the ground." }
      ],
      cta_text: "Plan Your Career Break"
    },
    "csr" => {
      name: "CSR / Group",
      title: "Corporate Volunteering With Real-World Impact",
      subtitle: "Custom-built programs aligning your CSR goals with community need.",
      intro: "Partner with us to give your team meaningful volunteer experiences — teaching, IT training, fundraising, and community support, scaled to your goals and timeline.",
      hero_image: "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/Corp-volunteers-qtnpzc0xqxs7s8lfwz4hbnbkr8ompv3ekisl16fb0g.jpg",
      icon: "ph-buildings",
      duration: "One day to several months — fully customizable",
      benefits: [
        { icon: "ph-strategy", title: "Leadership Building", text: "Develop communication and problem-solving in the field." },
        { icon: "ph-handshake", title: "Cross-cultural Skills", text: "Adaptability that translates back to the workplace." },
        { icon: "ph-users-three", title: "Team Cohesion", text: "Shared purpose builds collaboration that sticks." },
        { icon: "ph-heart", title: "Direct Impact", text: "Help disadvantaged students gain real-world skills." },
        { icon: "ph-star", title: "Brand Reputation", text: "Authentic CSR story your stakeholders will value." },
        { icon: "ph-slider-horizontal", title: "Flexible Format", text: "From single-day workshops to multi-month residencies." }
      ],
      journey: [
        { step: "1", title: "Choose Format", text: "Select volunteer or internship application type." },
        { step: "2", title: "Share Goals", text: "Tell us about your team's skills and CSR objectives." },
        { step: "3", title: "Consult", text: "Receive project suggestions; book a call to refine." },
        { step: "4", title: "Deploy", text: "Comprehensive handbook with full operational guidance." }
      ],
      cta_text: "Apply for Free — No Registration Fee"
    }
  }.freeze

  def initialize(slug, data)
    @slug = slug
    @name = data[:name]
    @title = data[:title]
    @subtitle = data[:subtitle]
    @intro = data[:intro]
    @hero_image = data[:hero_image]
    @icon = data[:icon]
    @duration = data[:duration]
    @benefits = data[:benefits]
    @journey = data[:journey]
    @cta_text = data[:cta_text]
  end

  def path
    case slug
    when "retired"      then "/volunteer/retired"
    when "gap_year"     then "/volunteer/gap-year"
    when "internship"   then "/volunteer/internship"
    when "career_break" then "/volunteer/career-break"
    when "csr"          then "/volunteer/csr"
    end
  end

  def self.find(slug)
    data = AUDIENCES[slug.to_s]
    return nil unless data
    new(slug.to_s, data)
  end

  def self.all
    AUDIENCES.map { |slug, data| new(slug, data) }
  end
end
