module CsvRowModelSample
  module RowModels
    module Import
      extend ActiveSupport::Autoload

      eager_autoload do
        autoload :UserImportRow
        autoload :ContactBookImportRow
      end
    end
  end
end