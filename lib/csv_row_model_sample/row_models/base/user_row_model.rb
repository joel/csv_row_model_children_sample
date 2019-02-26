module CsvRowModelSample
  module RowModels
    module Base
      module UserRowModel
        extend ActiveSupport::Concern
        include CsvRowModel::Model

        included do
          column :name
          column :email, parse: ->(email) { email.downcase }
        end 
      end 
    end 
  end 
end 