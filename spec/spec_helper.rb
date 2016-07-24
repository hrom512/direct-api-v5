require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

ENV['RAILS_ENV'] ||= 'test'

%w(support shared).each do |dir|
  Dir[File.expand_path(File.join(File.dirname(__FILE__), dir, '**', '*.rb'))].each { |f| require f }
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
end
