# Be sure to restart your server when you modify this file.

# Application-wide Content Security Policy.
# See https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self, :https
    policy.font_src    :self, :https, :data
    policy.img_src     :self, :https, :data, :blob
    policy.object_src  :none
    policy.frame_ancestors :none
    policy.base_uri    :self
    policy.form_action :self
    policy.connect_src :self, :https
    policy.script_src  :self, :https, "https://unpkg.com", "https://omp.openskills.dev"
    policy.style_src   :self, :https, :unsafe_inline
    # YouTube embeds + sendimpact application iframe
    policy.frame_src   :self, "https://www.youtube.com", "https://youtube.com",
                              "https://sendimpact.com"
  end

  # Nonces for importmap and inline tags Rails generates itself.
  config.content_security_policy_nonce_generator = ->(request) { SecureRandom.base64(16) }
  config.content_security_policy_nonce_directives = %w[script-src]

  # Start in report-only mode so a misconfiguration doesn't break the site;
  # flip to enforcing once production traffic shows no false positives.
  config.content_security_policy_report_only = true
end
