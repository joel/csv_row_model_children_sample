module CsvRowModelSample
  module RowModels
    module Base
      RSpec.describe UserRowModel do
        let(:fake_klass) do
          Class.new do
            include CsvRowModelSample::RowModels::Base::UserRowModel
          end
        end

        it do
          expect(fake_klass.headers).to eql([:name, :email])
        end
      end
    end
  end
end