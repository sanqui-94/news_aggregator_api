RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    # Prevents mocking methods that don't exist on real objects
    # Catches typos and interface drift early
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Re-run failures first, then the rest in random order
  config.filter_run_when_matching :focus

  # Persists which examples failed so --only-failures works
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Prevents accidental reliance on test ordering
  config.order = :random
  Kernel.srand config.seed
end
