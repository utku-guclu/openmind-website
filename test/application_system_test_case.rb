require "test_helper"
require "capybara/rails"
require "selenium-webdriver"

# System tests drive a real Chromium. By default the browser is **visible** so
# you can watch the suite run — set HEADLESS=1 to hide it (CI mode).
#
#   bin/rails test:system            # headed (default)
#   HEADLESS=1 bin/rails test:system # headless
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  if ENV["HEADLESS"] == "1"
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 900]
  else
    driven_by :selenium, using: :chrome, screen_size: [1400, 900] do |options|
      # Slow each input by 100ms so the run is observable. Set FAST=1 to skip.
      options.add_argument("--auto-open-devtools-for-tabs") if ENV["DEVTOOLS"] == "1"
    end
  end
end
