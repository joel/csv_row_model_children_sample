module CsvRowModelSample
  module RowModels
    module Base
      extend ActiveSupport::Autoload

      eager_autoload do
        autoload :UserRowModel
        autoload :ContactBookRowModel
      end
    end
  end
end