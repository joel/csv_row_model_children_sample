# CsvRowModelSample

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/csv_row_model_sample`. To experiment with that code, run `bin/console` for an interactive prompt.

Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csv_row_model_sample'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv_row_model_sample

## Usage

Importing followinng CSV 

```
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
```

Models 

```
class ContactBook < ApplicationRecord
  validates :name, presence: true
  has_many :users
end 
```

```
class User < ApplicationRecord
  validates :email, presence: true
  belongs_to :contact_book
end 
```

Importers

```
class ContactBookImportRow
  include CsvRowModel::Model

  column :book_name
  
  include CsvRowModel::Import

  validates :book_name, presence: true

  represents_one :contact_book, dependencies: %i(book_name) do
    ::ContactBook.where(name: book_name).first_or_create
  end

  has_many :users, UserImportRow
end 
```

```
class UserImportRow
  include CsvRowModel::Model

  column :email, parse: ->(email) { email.downcase }
  column :first_name
  column :last_name

  include CsvRowModel::Import

  validates :email, presence: true

  represents_one :user, dependencies: %i(email) do
    user = ::User.where(email: email).first_or_create
    user.update(name: "#{attributes[:first_name]} #{attributes[:last_name]}")
    user
  end
end 
```

We get 

```
expect(rows[0].contact_book.name).to eql('Perso')
expect(
  rows[0].users.map { |user_import_row| user_import_row.user.name }.sort
).to eql(["Cherry Howe", "Laree Crist", "Palmer Kiehn"])

expect(rows[1].contact_book.name).to eql('Pro')
expect(
  rows[1].users.map { |user_import_row| user_import_row.user.name }.sort
).to eql(["Judith Gibson", "Krishna Keebler"])
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/csv_row_model_sample. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CsvRowModelSample project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/csv_row_model_sample/blob/master/CODE_OF_CONDUCT.md).
