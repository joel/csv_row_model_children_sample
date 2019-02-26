module CsvRowModelSample
  module RowModels
    module Base
      RSpec.describe ContactBookRowModel do
        let(:fake_klass) do
          Class.new do
            include CsvRowModelSample::RowModels::Base::ContactBookRowModel
          end
        end

        it do
          expect(fake_klass.headers).to eql([:book_name])
        end
      end
    end
  end
end