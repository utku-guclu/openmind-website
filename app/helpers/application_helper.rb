module ApplicationHelper
  def site_setting(key)
    @site_settings_cache ||= SiteSetting.with_attached_file.includes(:rich_text_content).index_by(&:key)
    @site_settings_cache[key.to_s]
  end

  # Returns the image URL for a SiteSetting that has an Active Storage file,
  # falling back to the setting's value (plain URL string) if no file is attached.
  def site_setting_image_url(key)
    setting = site_setting(key)
    return nil unless setting
    if setting.file.attached?
      url_for(setting.file)
    else
      setting.value.presence
    end
  end

  # Returns a Schema.org JSON-LD graph for the current page. Always includes
  # the Organization + WebSite; adds Article when a @post is in scope.
  def json_ld_schema_for(controller_name, action_name, assigns)
    org = organization_schema
    site = website_schema(org)
    graph = [org, site]

    post = assigns["post"]
    if controller_name == "posts" && action_name == "show" && post.present?
      graph << article_schema(post, org)
    end

    project = assigns["project"]
    if controller_name == "projects" && action_name == "show" && project.present?
      graph << webpage_schema(project.title, project.summary, org)
    end

    destination = assigns["destination"]
    if controller_name == "destinations" && action_name == "show" && destination.present?
      graph << webpage_schema("Volunteer in #{destination.name}", destination.summary, org)
    end

    { "@context" => "https://schema.org", "@graph" => graph }
  end

  private

  def organization_schema
    {
      "@type" => "Organization",
      "@id"  => "#{root_url}#organization",
      "name" => "OpenmindProjects",
      "url"  => root_url,
      "logo" => {
        "@type" => "ImageObject",
        "url"   => image_url("/omp-globe.png")
      },
      "sameAs" => ["https://www.facebook.com/openmindprojects"]
    }
  end

  def website_schema(org)
    {
      "@type"     => "WebSite",
      "@id"       => "#{root_url}#website",
      "url"       => root_url,
      "name"      => "OpenmindProjects",
      "publisher" => { "@id" => org["@id"] },
      "inLanguage" => "en-US"
    }
  end

  def webpage_schema(title, description, org)
    {
      "@type"       => "WebPage",
      "url"         => request.original_url,
      "name"        => title,
      "description" => description,
      "isPartOf"    => { "@id" => "#{root_url}#website" },
      "publisher"   => { "@id" => org["@id"] },
      "inLanguage"  => "en-US"
    }
  end

  def article_schema(post, org)
    {
      "@type"         => "Article",
      "headline"      => post.title,
      "description"   => post.summary,
      "datePublished" => post.published_at&.iso8601,
      "dateModified"  => post.updated_at.iso8601,
      "author"        => post.author ? { "@type" => "Person", "name" => post.author.name } : { "@type" => "Organization", "@id" => org["@id"] },
      "publisher"     => { "@id" => org["@id"] },
      "mainEntityOfPage" => { "@type" => "WebPage", "@id" => request.original_url },
      "inLanguage"    => "en-US"
    }
  end
end
