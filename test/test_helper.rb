ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  # Fixtures are not used here; we build records inline so each test reads as a
  # self-contained scenario. If you start sharing setup, lean on `setup` blocks
  # before you reach for fixtures.
end
