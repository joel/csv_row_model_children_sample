module CsvRowModelSample
  module RowModels
    module Export
      class UserExportRow
        module UserRowModelExport
          extend ActiveSupport::Concern
          include CsvRowModel::Model

          included do
            column :book_name
          end 
        end
        include UserRowModelExport

        include CsvRowModelSample::RowModels::Base::UserRowModel
                
        include CsvRowModel::Export
        
        def book_name
          nil
        end
        
      end 
    end 
  end 
end