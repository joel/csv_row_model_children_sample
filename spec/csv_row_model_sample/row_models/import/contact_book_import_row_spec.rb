module CsvRowModelSample
  module RowModels
    module Import
      RSpec.describe ContactBookImportRow do 
        
        with_model :ContactBook do
          table do |t|         
            t.string :name
            t.timestamps
          end
       
          model do
            validates :name, presence: true
            has_many :users
          end 
        end

        with_model :User do
          table do |t|         
            t.string :name
            t.string :email
            t.references :contact_book
            t.timestamps
          end
       
          model do
            validates :email, presence: true
            belongs_to :contact_book
          end 
        end 
        
        let(:csv_source) do
          [
            [ 'Book Name' , 'Email'                          , 'First Name', 'Last Name' ],
            [ 'Perso'     , ''                               , ''          , ''          ],
            [ ''          , 'cherry.howe@lesch.com'          , 'Cherry'    , 'Howe'      ],
            [ ''          , ''                               , 'Joel'      , 'AZEMAR'    ], # Invalid record will be ignored 
            [ ''          , 'palmer.kiehn@fay.ca'            , 'Palmer'    , 'Kiehn'     ],
            [ ''          , 'laree.crist@reynolds.com'       , 'Laree'     , 'Crist'     ],
            [ 'Pro'       , ''                               , ''          , ''          ],
            [ ''          , 'judith.gibson@hoeger.co.uk'     , 'Judith'    , 'Gibson'    ],
            [ ''          , 'krishna.keebler@wuckerthoppe.us', 'Krishna'   , 'Keebler'   ],
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
        
        let!(:importer) { CsvRowModel::Import::File.new(file.path, row_model_class, context) }
        let(:rows)      {[]}

        before do 
          while (row = importer.next) do 
            if row.valid? and row.is_a?(ContactBookImportRow)
              rows << row
            end
          end
        end
        
        it { expect(rows.size).to eql(2) }

        context 'row 1' do
          it do
            expect(rows[0].contact_book.name).to eql('Perso')
            expect(
              rows[0].users.map { |user_import_row| user_import_row.user.name }.sort
            ).to eql(["Cherry Howe", "Laree Crist", "Palmer Kiehn"])
          end
        end

        context 'row 2' do
          it do
            expect(rows[1].contact_book.name).to eql('Pro')
            expect(
              rows[1].users.map { |user_import_row| user_import_row.user.name }.sort
            ).to eql(["Judith Gibson", "Krishna Keebler"])
          end
        end
                
      end  
    end 
  end 
end