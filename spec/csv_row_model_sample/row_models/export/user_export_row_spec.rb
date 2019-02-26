module CsvRowModelSample
  module RowModels
    module Export
      RSpec.describe UserExportRow do 
        
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
        
        let(:users) do 
          [
            ::User.new({ name: 'Joel AZEMAR', email: 'joel.azemar@gmail.com' })
          ]
        end

        let(:export_file) { CsvRowModel::Export::File.new(described_class) }
        
        let(:context) {{}}
        
        before do
          users.each do |user|
            export_file.generate { |csv| csv << user }
          end 
        end 

        it do 
          expect(export_file.to_s).to eql("book_name,name,email\n,Joel AZEMAR,joel.azemar@gmail.com\n")
        end 
      end  
    end 
  end 
end