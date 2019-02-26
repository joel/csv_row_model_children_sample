module CsvRowModelSample
  module RowModels
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Base
      autoload :Import
      autoload :Export
    end
  end
end
