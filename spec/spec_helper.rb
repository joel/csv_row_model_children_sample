require "bundler/setup"
require "csv_row_model_sample"

require 'pry'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require File.dirname(__FILE__) + "/support/database.rb"
require File.dirname(__FILE__) + "/support/with_model.rb"
