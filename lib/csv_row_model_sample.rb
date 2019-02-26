require "csv_row_model_sample/version"
require "active_support/dependencies/autoload"

require 'csv_row_model'

module CsvRowModelSample
  extend ActiveSupport::Autoload
  
  class Error < StandardError; end

  autoload :RowModels
end
