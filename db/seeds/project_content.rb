# db/seeds/project_content.rb
# Run with: bin/rails runner db/seeds/project_content.rb

CONTENT = {
  "teaching-volunteer" => <<~HTML,
    <h2>Why Teaching Volunteer Opportunities in Thailand</h2>
    <p>Teaching Volunteer Opportunities with OpenmindProjects offers rewarding experiences when you teach and practice English the learning by doing way. We help you! We'll send a Volunteer Handbook, then help and train you when you volunteer.</p>
    <ul>
      <li><strong>Make a difference:</strong> Support underprivileged children, help them learn English, focusing on speaking and listening.</li>
      <li><strong>Gain valuable experience:</strong> Develop your teaching skills together with us, especially valuable for aspiring teachers.</li>
      <li><strong>Immerse yourself in a new culture:</strong> Experience vibrant Southeast Asian culture and learn about local traditions.</li>
      <li><strong>Personal growth:</strong> Step outside your comfort zone and develop new skills and a deeper understanding of another world.</li>
      <li><strong>Connect with a local community:</strong> Build meaningful friendships with local students, teachers and other volunteers.</li>
      <li><strong>Contribute to sustainable development:</strong> Help break the cycle of poverty. Empower students with English communication skills.</li>
    </ul>

    <h2>How Volunteers Make an Impact</h2>
    <ul>
      <li><strong>Teach English in an Engaging Way:</strong> Use interactive and enjoyable methods — role-playing, games, and songs — making learning English fun and effective.</li>
      <li><strong>Create Opportunities:</strong> Help students gain confidence to speak English and secure better job prospects, particularly in the tourism sector.</li>
      <li><strong>Make a Lasting Impact:</strong> Make a real difference in the lives of underprivileged students. Empower and motivate them to learn.</li>
      <li><strong>Practical Experience:</strong> Gain hands-on experience teaching English as a foreign language in our supportive environment.</li>
      <li><strong>Cultural Immersion:</strong> Experience the rich culture of Southeast Asia, make local friends and make a positive contribution.</li>
    </ul>

    <h2>Who Are the Students?</h2>
    <p>OpenmindProjects focuses on young people from Thailand, Laos, Myanmar, and Cambodia who come from underprivileged backgrounds and have had limited access to quality education.</p>
    <ul>
      <li><strong>School Children:</strong> Pre-school (ages 5–6), primary school, or secondary school students.</li>
      <li><strong>Trainees:</strong> Young people who participate in OpenmindProjects' training program to learn English, IT skills, and other life skills. They often come from villages or migrant communities.</li>
    </ul>

    <h2>The Teaching Environment</h2>
    <ul>
      <li><strong>Limited Resources:</strong> Schools in rural areas have limited resources. Good to bring flashcards, maps, pictures, globes, laptops if you can. We help you too.</li>
      <li><strong>Large Classes:</strong> Classes can range from 10 to 40 students, up to 60 in Laos.</li>
      <li><strong>Variable IT Access:</strong> OpenmindProjects emphasizes IT training, but access to computers and the internet varies.</li>
      <li><strong>Cultural Differences:</strong> Students are often shy to speak English. Encourage them to make simple sentences and conversation.</li>
    </ul>

    <h2>Team Teaching</h2>
    <p>OpenmindProjects strongly encourages team teaching — working together with a local teacher in the classroom.</p>
    <ul>
      <li><strong>Facilitate Communication:</strong> The local teacher can help explain and bridge the language barrier.</li>
      <li><strong>Utilize Local Knowledge:</strong> The teacher knows the students and the curriculum.</li>
      <li><strong>Provide Extra Practice:</strong> Volunteers contribute motivation and confidence to speak simple English.</li>
    </ul>

    <h2>Volunteer Requirements</h2>
    <ul class="checklist">
      <li>All volunteers are required to have adequate travel insurance</li>
      <li>All volunteers must speak good English</li>
      <li>Volunteer must be 18 years of age or older</li>
      <li>Volunteers under 18 are welcome with their parents</li>
    </ul>
  HTML

  "computer-training" => <<~HTML,
    <h2>Why Volunteer for IT Training and Development</h2>
    <p>Looking for a meaningful way to use your tech skills? Volunteer with OpenmindProjects — a great opportunity to help disadvantaged youth, gain valuable experience, and connect with local people.</p>
    <ul>
      <li><strong>Bridge the Digital Divide:</strong> Empower young people in Southeast Asia with important IT skills for today's world.</li>
      <li><strong>Contribute to Sustainable Development:</strong> Be part of our efforts to help students through education and technology.</li>
      <li><strong>Help OpenmindProjects:</strong> Help develop IT skills, website, training, and more.</li>
    </ul>

    <h2>What You'll Gain</h2>
    <ul>
      <li><strong>Apply your IT skills:</strong> Hands-on experience helping local people and our NGO.</li>
      <li><strong>Cross-Cultural Exchange:</strong> Work and learn in another culture and gain new perspectives.</li>
      <li><strong>Personal Growth:</strong> Develop your teaching and other skills, build confidence and forge meaningful connections.</li>
    </ul>

    <h2>How Volunteers Make an Impact</h2>
    <ul>
      <li><strong>Bridge the Digital Divide:</strong> Expand access to technology and IT education for underprivileged youth. Open doors to new opportunities.</li>
      <li><strong>Develop Essential Skills:</strong> Help design engaging learning material and deliver IT training that equips young people with important skills.</li>
      <li><strong>Build a Brighter Future:</strong> Contribute to sustainable development and empower communities.</li>
      <li><strong>Inspire Change:</strong> Be a role model and mentor to young people. Demonstrate the positive impact of technology and education.</li>
    </ul>

    <h2>IT Volunteer Opportunities</h2>
    <p>You can contribute your IT skills in various ways:</p>
    <ul>
      <li>Developing IT solutions</li>
      <li>Creating engaging learning materials</li>
      <li>Delivering online lessons</li>
      <li>Contributing to the OpenSkills online platform</li>
      <li>Providing website and IT support</li>
    </ul>
    <p>We welcome both onsite and online volunteers.</p>

    <h2>About the OpenSkills Platform</h2>
    <p>OpenSkills is an innovative, free, and open-source online platform designed to empower disadvantaged youth in Southeast Asia. It provides accessible technology education and job skills training through a game-based learning environment that tracks learner progress and fosters a sense of community.</p>

    <h2>Volunteer Requirements</h2>
    <ul class="checklist">
      <li>All volunteers are required to have adequate travel insurance</li>
      <li>All volunteers must speak good English</li>
      <li>Volunteer must be 18 years of age or older</li>
      <li>Volunteers under 18 are welcome with their parents</li>
    </ul>
  HTML

  "learning-camp-thailand" => <<~HTML,
    <h2>Why Volunteer at Learning Camps in Thailand</h2>
    <p>OpenmindProjects has hosted popular holiday and learning camps for young students in Southeast Asia for many years. These camps are designed to help village, migrant, and ethnic minority students learn English, improve their IT skills, and use the internet to explore the world.</p>

    <h2>What Makes Our Camps Special</h2>
    <ul>
      <li><strong>Interactive Learning:</strong> We go beyond traditional teaching methods, encouraging campers to learn through hands-on activities, online research, problem solving and team work.</li>
      <li><strong>Focus on Essential Skills:</strong> Campers improve their English and IT skills, develop valuable critical thinking skills and learn about global issues like climate, food, health, and future jobs.</li>
      <li><strong>Cultural Exchange:</strong> Volunteers and campers learn from each other, fostering cultural understanding and lasting friendships.</li>
    </ul>

    <h2>How Volunteers Make an Impact</h2>
    <ul>
      <li><strong>Inspiring Role:</strong> Guide and support campers. Help them develop essential skills and confidence.</li>
      <li><strong>Interactive Learning:</strong> Participate in hands-on activities, discussions, and projects.</li>
      <li><strong>Cultural Exchange:</strong> Share your culture and learn from the students and local people.</li>
      <li><strong>Make a Difference:</strong> Create positive change in the lives of underprivileged students.</li>
      <li><strong>Break Poverty Cycles:</strong> Empower learners for better job opportunities and a brighter future.</li>
    </ul>

    <h2>Camp Structure</h2>
    <p>Each camp follows a three-stage learning process:</p>
    <ul>
      <li><strong>Brainstorming:</strong> Campers research and discuss specific camp themes, gathering information and sharing knowledge.</li>
      <li><strong>Activating:</strong> Teams work together to identify and analyze community problems related to the themes.</li>
      <li><strong>Implementing:</strong> Teams develop innovative solutions, evaluate their feasibility, and present their ideas to the community.</li>
    </ul>

    <h2>Why These Camps Are Needed</h2>
    <ul>
      <li><strong>Educational Inequality:</strong> Many children in Southeast Asia face limited access to quality education due to poverty and unequal distribution of resources.</li>
      <li><strong>Traditional Teaching Methods:</strong> Rote learning methods often fail to equip students with the skills needed for the modern world.</li>
      <li><strong>Bridging the Gap:</strong> OpenmindProjects Learning Camps provide a unique learning experience combining technology, interactive activities, and cultural exchange.</li>
    </ul>

    <h2>Volunteer Requirements</h2>
    <ul class="checklist">
      <li>All volunteers are required to have adequate travel insurance</li>
      <li>All volunteers must speak good English</li>
      <li>Volunteer must be 18 years of age or older</li>
      <li>Volunteers under 18 are welcome with their parents</li>
    </ul>
  HTML

  "volunteer-burma-migrants" => <<~HTML,
    <h2>Why Volunteer in the Thailand-Myanmar Border Mountains</h2>
    <p>There are several compelling reasons to volunteer with Burmese, ethnic minority, and migrant students through OpenmindProjects:</p>
    <ul>
      <li><strong>Make a lasting impact:</strong> Help marginalized students gain essential skills, overcome poverty, and find better job opportunities.</li>
      <li><strong>Partner with a dedicated organization:</strong> Work with a non-profit charity committed to creating sustainable change in the region.</li>
      <li><strong>Directly support vulnerable youth:</strong> Help some of the most marginalized and poor young people in Thailand.</li>
      <li><strong>Gain valuable experience:</strong> Teach English, Thai, IT, and internet skills while supporting students in online research and discussions.</li>
      <li><strong>Experience cultural immersion:</strong> Learn about the local people, customs, and way of life along the Thai-Myanmar border.</li>
      <li><strong>Enjoy the beautiful surroundings:</strong> Volunteer in the stunning natural environment of the Thai-Burmese mountains.</li>
    </ul>

    <h2>What to Expect</h2>
    <ul>
      <li><strong>Meaningful Role:</strong> Guide and support students from marginalized communities in Mae Sot and Umphang.</li>
      <li><strong>Engaging Teaching:</strong> Teach English, Thai, IT, and internet skills using interactive methods.</li>
      <li><strong>Cultural Immersion:</strong> Experience the unique culture of the Thai-Myanmar border region.</li>
      <li><strong>Personal Growth:</strong> Gain valuable teaching experience and enhance your cross-cultural communication skills.</li>
    </ul>

    <h2>How You'll Make an Impact</h2>
    <ul>
      <li><strong>Educational Empowerment:</strong> Equip students with the skills and confidence they need to succeed in the modern world.</li>
      <li><strong>Breaking Barriers:</strong> Help marginalized youth overcome the challenges they face and access better opportunities.</li>
      <li><strong>Building Bridges:</strong> Foster cultural understanding and create lasting connections with students and the local community.</li>
      <li><strong>Making a Difference:</strong> Directly contribute to empowering students, helping them break the cycle of poverty.</li>
    </ul>

    <h2>Support Provided to Volunteers</h2>
    <ul>
      <li><strong>Cultural Orientation:</strong> Introductions to local customs, people, and way of life to help you adjust smoothly.</li>
      <li><strong>Teaching Assistance:</strong> Guidance and resources to ensure effective English teaching, even without prior experience.</li>
      <li><strong>IT and Internet Training:</strong> Support in teaching IT and internet skills to students.</li>
    </ul>

    <h2>Volunteer Requirements</h2>
    <ul class="checklist">
      <li>All volunteers are required to have adequate travel insurance</li>
      <li>All volunteers must speak good English</li>
      <li>Volunteer must be 18 years of age or older</li>
      <li>Volunteers under 18 are welcome with their parents</li>
    </ul>
  HTML

  "train-the-trainer" => <<~HTML,
    <h2>Why the Train the Trainer Program?</h2>
    <p>The OpenmindProjects Train the Trainer (TTT) program is our flagship capacity-building initiative. It transforms motivated young people from our local communities into skilled educators and community leaders — creating a sustainable, multiplying impact that outlasts any single volunteer visit.</p>
    <ul>
      <li><strong>Sustainable Impact:</strong> Train local educators who will continue teaching long after volunteers leave.</li>
      <li><strong>Multiplying Effect:</strong> Each trainer you develop goes on to teach dozens of students in their own community.</li>
      <li><strong>Leadership Development:</strong> Help young people transition from students to confident, skilled trainers.</li>
      <li><strong>Community Ownership:</strong> Empower local people to take ownership of their own education and development.</li>
    </ul>

    <h2>What Trainers Learn</h2>
    <p>The TTT curriculum covers a comprehensive set of skills:</p>

    <table>
      <thead>
        <tr><td><strong>Teaching Skills</strong></td><td><strong>Technical Skills</strong></td></tr>
      </thead>
      <tbody>
        <tr><td>Interactive English teaching methods</td><td>Computer and internet basics</td></tr>
        <tr><td>Learning camp facilitation</td><td>Digital content creation</td></tr>
        <tr><td>Classroom management</td><td>Online research and fact-checking</td></tr>
        <tr><td>Student motivation techniques</td><td>OpenSkills platform usage</td></tr>
      </tbody>
    </table>

    <h2>The Path to Becoming a Trainer</h2>
    <ol>
      <li><strong>Join as a Trainee:</strong> Participants first complete OpenmindProjects' core English and IT training program.</li>
      <li><strong>Volunteer 250+ Hours:</strong> Demonstrate commitment by contributing meaningful volunteer time.</li>
      <li><strong>Complete TTT Curriculum:</strong> Formal training in pedagogy, facilitation, and leadership.</li>
      <li><strong>Earn "Hero" Status:</strong> Graduates gain access to the OpenSkills platform's advanced features including publishing posts and job marketplace access.</li>
    </ol>

    <h2>How Volunteers Help</h2>
    <ul>
      <li><strong>Co-facilitate workshops:</strong> Work alongside local staff to deliver TTT sessions.</li>
      <li><strong>Curriculum development:</strong> Help create engaging learning materials and lesson plans.</li>
      <li><strong>Mentorship:</strong> Provide one-on-one coaching to trainee-teachers during practice sessions.</li>
      <li><strong>English coaching:</strong> Strengthen trainees' English confidence for public speaking and teaching.</li>
      <li><strong>IT support:</strong> Help trainees build their digital skills and use online tools effectively.</li>
    </ul>

    <h2>Volunteer Requirements</h2>
    <ul class="checklist">
      <li>All volunteers are required to have adequate travel insurance</li>
      <li>All volunteers must speak good English</li>
      <li>Volunteer must be 18 years of age or older</li>
      <li>Prior teaching or training experience is a plus but not required</li>
    </ul>
  HTML

  "responsible-voluntourism" => <<~HTML,
    <h2>What is Responsible Voluntourism?</h2>
    <p>Responsible Voluntourism with OpenmindProjects combines meaningful volunteer work with cultural immersion and exploration of Southeast Asia. We believe that travel and volunteering can — and should — create genuine, lasting benefits for local communities rather than simply providing experiences for visitors.</p>
    <ul>
      <li><strong>Community-First Approach:</strong> Every activity is designed around what local communities actually need, not what looks good on social media.</li>
      <li><strong>Ethical Standards:</strong> We adhere to best-practice guidelines for ethical volunteering, including child safety protocols.</li>
      <li><strong>Transparent Impact:</strong> We share honest data about what volunteers contribute and the outcomes achieved.</li>
      <li><strong>Cultural Respect:</strong> Volunteers are prepared with cultural orientation to engage respectfully and meaningfully.</li>
    </ul>

    <h2>What You'll Do</h2>
    <p>Your time is split between structured volunteer work and guided cultural exploration:</p>
    <ul>
      <li><strong>Morning sessions:</strong> Teach English, IT skills, or support learning camps alongside local staff.</li>
      <li><strong>Afternoon activities:</strong> Cultural workshops, language learning, cooking classes, and community visits.</li>
      <li><strong>Weekend excursions:</strong> Guided exploration of local temples, markets, nature, and communities.</li>
      <li><strong>Evening reflections:</strong> Group debriefs to process experiences and deepen cultural understanding.</li>
    </ul>

    <h2>Destinations</h2>
    <p>Our Responsible Voluntourism programs are available across our three main regions:</p>
    <ul>
      <li><strong>Chiang Rai, Thailand:</strong> Work with migrant and ethnic minority youth in the Golden Triangle region.</li>
      <li><strong>Mae Sot, Thailand:</strong> Support Burmese and Karen communities along the Myanmar border.</li>
      <li><strong>Nepal:</strong> Teach English and support conservation and eco-tourism initiatives.</li>
    </ul>

    <h2>Who This Program Is For</h2>
    <ul>
      <li>Gap year students seeking meaningful travel experiences</li>
      <li>Career-breakers wanting to give back while exploring Southeast Asia</li>
      <li>Families traveling together (children welcome with parents)</li>
      <li>Retired professionals with skills and time to share</li>
      <li>Groups and corporate social responsibility teams</li>
    </ul>

    <h2>Volunteer Requirements</h2>
    <ul class="checklist">
      <li>All volunteers are required to have adequate travel insurance</li>
      <li>All volunteers must speak good English</li>
      <li>Volunteer must be 18 years of age or older</li>
      <li>Volunteers under 18 are welcome with their parents</li>
    </ul>
  HTML
}.freeze

puts "=== Seeding project rich-text content ==="

CONTENT.each do |slug, html|
  project = Project.find_by(slug: slug)
  unless project
    puts "  SKIP #{slug} — not found in DB"
    next
  end

  project.update!(content: html)
  puts "  ✓ #{slug}"
end

puts "\n=== Done ==="
Project.all.each { |p| puts "  #{p.slug}: content=#{p.content.present?}" }
