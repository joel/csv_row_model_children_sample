module CsvRowModelSample
  module RowModels
    module Base
      module ContactBookRowModel
        extend ActiveSupport::Concern
        include CsvRowModel::Model

        included do
          column :book_name
        end 
      end 
    end 
  end 
end 