module CsvRowModelSample
  module RowModels
    module Import
      class UserImportRow
        include CsvRowModelSample::RowModels::Base::UserRowModel
        
        module UserRowModelImport
          extend ActiveSupport::Concern
          include CsvRowModel::Model

          included do
            column :first_name
            column :last_name
          end 
        end
        include UserRowModelImport
        
        include CsvRowModel::Import

        validates :email, presence: true
      
        represents_one :user, dependencies: %i(email) do
          user = ::User.where(email: email).first_or_create
          user.update(name: "#{attributes[:first_name]} #{attributes[:last_name]}")
          user
        end
      end 
    end 
  end 
end