module CsvRowModelSample
  module RowModels
    module Import
      RSpec.describe UserImportRow do 
      
        with_model :User do
          table do |t|         
            t.string :name
            t.string :email
            t.timestamps
          end
       
          model do
            validates :email, presence: true
          end 
        end       
        
        let(:csv_source) do
          [
            [ 'Book Name', 'Email'                , 'First Name', 'Last Name' ],
            [ ''         , 'joel.azemar@gmail.com', 'Joel'      , 'AZEMAR'    ],
          ]
        end 

        let(:csv_string) do
          CSV.generate do |csv|
            csv_source.each { |row| csv << row }
          end
        end 

        let(:file) do
          file = begin
            file = Tempfile.new(['file','.csv'])
            file.write(csv_string)
            file.rewind
            file
          end
        end 
        
        let(:row_model_class) { described_class }
        
        let(:context) {{}}
        
        subject do
          CsvRowModel::Import::File.new(file.path, row_model_class, context).next
        end 
        
        it do 
          expect(subject.user).to be_a(::User)
          expect(subject.user.name).to eql('Joel AZEMAR')
        end 
      end  
    end 
  end 
end