require 'csv_row_model'

csv_file = File.new((File.dirname(__FILE__) + '/spec/fixtures/users.csv'))
import = CsvRowModel::Import::File.new(csv_file.path, CsvRowModelSample::RowModels::Import::UserImportRow)
import.each { |importer| importer.save! }

CsvRowModelSample::Models::User.count
CsvRowModelSample::Models::User.destroy_all