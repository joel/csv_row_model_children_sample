source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gemspec

gem 'csv_row_model', git: 'https://github.com/joel/csv_row_model'

gem 'activesupport' #, '4.1.0'
gem 'activerecord'

group :development, :test do
  gem 'pry-byebug'
  gem 'sqlite3', '~> 1.3.6'
end

group :test do
  gem 'with_model'
end
