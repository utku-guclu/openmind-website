module ApplicationHelper
  def site_setting(key)
    @site_settings_cache ||= SiteSetting.with_attached_file.includes(:rich_text_content).index_by(&:key)
    @site_settings_cache[key.to_s]
  end
end
