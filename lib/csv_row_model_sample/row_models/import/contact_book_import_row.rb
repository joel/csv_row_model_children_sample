module CsvRowModelSample
  module RowModels
    module Import
      class ContactBookImportRow
        include CsvRowModelSample::RowModels::Base::ContactBookRowModel
        include CsvRowModel::Import

        validates :book_name, presence: true
      
        represents_one :contact_book, dependencies: %i(book_name) do
          ::ContactBook.where(name: book_name).first_or_create
        end

        has_many :users, UserImportRow
      end 
    end 
  end 
end