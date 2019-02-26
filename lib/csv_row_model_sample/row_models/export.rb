module CsvRowModelSample
  module RowModels
    module Export
      extend ActiveSupport::Autoload

      eager_autoload do
        autoload :UserExportRow
      end
    end
  end
end