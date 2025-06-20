# frozen_string_literal: true

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |m|
    m.verify_partial_doubles = true
  end
end
