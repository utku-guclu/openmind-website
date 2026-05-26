# frozen_string_literal: true

# Rake task to download all WordPress-hosted images and attach them via Active Storage.
# Run: bin/rails content:migrate_images
#
# This task is idempotent — it skips records that already have an attachment.
# It downloads images into a temp directory first, then attaches them.
namespace :content do
  desc "Download WordPress images and attach via Active Storage (local disk)"
  task migrate_images: :environment do
    require "open-uri"
    require "fileutils"

    DOWNLOAD_DIR = Rails.root.join("tmp", "wp_image_downloads")
    FileUtils.mkdir_p(DOWNLOAD_DIR)

    total = 0
    errors = 0

    def download_and_attach(record, attachment_name, url, label: nil)
      label ||= "#{record.class.name}##{record.try(:slug) || record.id}"

      if record.send(attachment_name).attached?
        puts "  ⏭  SKIP #{label} (already attached)"
        return :skipped
      end

      return :skipped if url.blank?

      puts "  ⬇  Downloading #{File.basename(URI.parse(url).path)} for #{label}..."
      filename = File.basename(URI.parse(url).path)
      local_path = DOWNLOAD_DIR.join(filename)

      # Download to temp file
      URI.open(url, "rb") do |remote|
        File.open(local_path, "wb") { |f| f.write(remote.read) }
      end

      # Detect content type
      content_type = case filename.downcase
                     when /\.jpe?g$/ then "image/jpeg"
                     when /\.png$/   then "image/png"
                     when /\.webp$/  then "image/webp"
                     when /\.gif$/   then "image/gif"
                     when /\.svg$/   then "image/svg+xml"
                     else "application/octet-stream"
                     end

      record.send(attachment_name).attach(
        io: File.open(local_path),
        filename: filename,
        content_type: content_type
      )
      puts "  ✅ Attached #{filename} → #{label}"
      :success
    rescue => e
      puts "  ❌ FAILED #{url}: #{e.message}"
      :error
    end

    puts "\n=== Phase 2A: Destination Hero Images ===\n"
    {
      "thailand" => "https://openmindprojects.org/wp-content/uploads/2024/11/family-volunteer-kids-trip15.jpg",
      "laos"     => "https://openmindprojects.org/wp-content/uploads/2024/11/volunteer-in-laos.jpg",
      "nepal"    => "https://openmindprojects.org/wp-content/uploads/2024/11/kids-nepal2-scaled.jpg"
    }.each do |slug, url|
      dest = Destination.find_by(slug: slug)
      unless dest
        puts "  ⚠️  Destination '#{slug}' not found, skipping"
        next
      end
      result = download_and_attach(dest, :hero_image, url)
      total += 1 if result == :success
      errors += 1 if result == :error
    end

    puts "\n=== Phase 2B: Volunteer Audience Hero Images ===\n"
    {
      "retired"      => "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/Babyboomer-volunteers-qtno6ssksufnh5tplixw56run0kv9y44xs8g92tdsg.jpg",
      "gap_year"     => "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/Volunteer-trekking-pumkpumpkin-farm-qm77x09pej61aotcs8m22qrvjsfvavgo08yc5qq6kg.jpg",
      "internship"   => "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/internship-qpum9thls3ji2yshyk8vftq4bw48qiyyrtvgz1e9qg.jpg",
      "career_break" => "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/Mae-Sot-Burmese-school-volunteer-qsl91fb6tn5kgaybi45m1l5g73qd9d1ymqtbifsdis.jpg",
      "csr"          => "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/Corp-volunteers-qtnpzc0xqxs7s8lfwz4hbnbkr8ompv3ekisl16fb0g.jpg",
      "family"       => "https://openmindprojects.org/wp-content/uploads/elementor/thumbs/family-volunteer-kids-trip15-qtnpzc0xqxs7s8lfwz4hbnbkr8ompv3ekisl16fb0g.jpg"
    }.each do |slug, url|
      audience = VolunteerAudience.find_by(slug: slug)
      unless audience
        puts "  ⚠️  VolunteerAudience '#{slug}' not found, skipping"
        next
      end
      result = download_and_attach(audience, :hero_image, url)
      total += 1 if result == :success
      errors += 1 if result == :error
    end

    puts "\n=== Phase 2C: Gallery Images (Family Audience) ===\n"
    family = VolunteerAudience.find_by(slug: "family")
    if family
      family.gallery_images.each do |gi|
        next if gi.file.attached?
        url = gi.image_url
        next if url.blank?
        result = download_and_attach(gi, :file, url, label: "GalleryImage##{gi.id}")
        total += 1 if result == :success
        errors += 1 if result == :error
      end
    else
      puts "  ⚠️  Family audience not found"
    end

    puts "\n=== Phase 2D: SiteSetting Images (View Content) ===\n"
    site_setting_image_keys = %w[
      navbar_whatwedo_image
      navbar_wherewework_image
      navbar_whovolunteers_image
      pillar_education_image
      pillar_development_image
      pillar_research_image
      about_hero_bg_image
      about_founders_image
    ]

    site_setting_image_keys.each do |key|
      setting = SiteSetting.find_by(key: key)
      unless setting
        puts "  ⚠️  SiteSetting '#{key}' not found, skipping"
        next
      end
      url = setting.value
      result = download_and_attach(setting, :file, url, label: "SiteSetting(#{key})")
      total += 1 if result == :success
      errors += 1 if result == :error
    end

    puts "\n=== Phase 2E: Hub Carousel Images ===\n"
    hub_setting = SiteSetting.find_by(key: "hub_images")
    if hub_setting && hub_setting.value.present?
      slides = JSON.parse(hub_setting.value) rescue []
      slides.each_with_index do |slide, idx|
        url = slide["url"]
        next if url.blank?

        # Create individual SiteSetting for each hub image
        key = "hub_image_#{idx}"
        img_setting = SiteSetting.find_or_create_by!(key: key) do |s|
          s.value = url
        end
        result = download_and_attach(img_setting, :file, url, label: "SiteSetting(#{key})")
        total += 1 if result == :success
        errors += 1 if result == :error

        # Update JSON with local reference
        slide["local_key"] = key
      end
      hub_setting.update!(value: slides.to_json)
    end

    puts "\n" + "=" * 60
    puts "Migration complete: #{total} images attached, #{errors} errors"
    puts "Downloaded files cached in: #{DOWNLOAD_DIR}"
    puts "=" * 60 + "\n"
  end

  desc "Verify all WordPress images have been migrated to Active Storage"
  task verify_images: :environment do
    puts "\n=== Verifying Image Migration ===\n"
    issues = 0

    puts "\nDestinations:"
    Destination.active.find_each do |d|
      if d.hero_image.attached?
        puts "  ✅ #{d.slug}: hero_image attached"
      elsif d.hero_image_url.present?
        puts "  ⚠️  #{d.slug}: still using hero_image_url (#{d.hero_image_url})"
        issues += 1
      else
        puts "  ➖ #{d.slug}: no image"
      end
    end

    puts "\nVolunteer Audiences:"
    VolunteerAudience.find_each do |a|
      if a.hero_image.attached?
        puts "  ✅ #{a.slug}: hero_image attached"
      elsif a.hero_image_url.present?
        puts "  ⚠️  #{a.slug}: still using hero_image_url"
        issues += 1
      else
        puts "  ➖ #{a.slug}: no image"
      end
    end

    puts "\nGallery Images:"
    AudienceGalleryImage.find_each do |gi|
      if gi.file.attached?
        puts "  ✅ GalleryImage##{gi.id}: file attached"
      elsif gi.image_url.present?
        puts "  ⚠️  GalleryImage##{gi.id}: still using image_url"
        issues += 1
      end
    end

    puts "\nSiteSetting Images:"
    %w[
      navbar_whatwedo_image navbar_wherewework_image navbar_whovolunteers_image
      pillar_education_image pillar_development_image pillar_research_image
      about_hero_bg_image about_founders_image
    ].each do |key|
      s = SiteSetting.find_by(key: key)
      if s&.file&.attached?
        puts "  ✅ #{key}: file attached"
      elsif s
        puts "  ⚠️  #{key}: no file attached (value: #{s.value&.truncate(60)})"
        issues += 1
      else
        puts "  ❌ #{key}: setting missing!"
        issues += 1
      end
    end

    puts "\n" + (issues.zero? ? "🎉 All images migrated!" : "⚠️  #{issues} items still need attention")
  end
end
