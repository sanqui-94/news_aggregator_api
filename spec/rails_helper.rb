require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'rspec/autorun'

# Auto-require everything in spec/support — shared contexts, custom matchers,
# helper modules live here and are loaded once for the whole suite
Rails.root.glob('spec/support/**/*.rb').sort_by(&:to_s).each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # Use FactoryBot methods (create, build, etc.) without the FactoryBot:: prefix
  config.include FactoryBot::Syntax::Methods

  # Each test runs in a transaction that rolls back after — no manual cleanup needed
  config.use_transactional_fixtures = true

  # Infer spec type from file location — models from spec/models, requests from
  # spec/requests, etc. without needing to tag every describe block
  config.infer_spec_type_from_file_location!

  # Filter noise from Rails gems in failure backtraces
  config.filter_rails_from_backtrace!
end

# Wire Shoulda Matchers to RSpec and Rails
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
