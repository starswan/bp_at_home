source 'http://rubygems.org'

ruby '2.2.4'

gem 'rails', '4.2.5'
gem 'pg'
gem 'haml-rails'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'simple_form'
# gem 'activeadmin', github: 'activeadmin', branch: '0-6-stable'
gem 'activeadmin', github: 'activeadmin'
gem 'devise'

group :production do
  gem 'newrelic_rpm'
  gem 'thin'
end

group :development do
  gem 'byebug'
end

gem 'uglifier'
gem 'twitter-bootstrap-rails', git: 'git://github.com/seyhunak/twitter-bootstrap-rails.git',
                               ref: '2b319805a99c2db3a86738fc4d7ad8c77654bbb2'

# group :assets do
  # gem 'sass-rails',   '~> 3.2.3'
  # gem 'coffee-rails', '~> 3.2.1'
  # gem 'uglifier', '>= 1.0.3'
  # gem 'twitter-bootstrap-rails', git: 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
  # gem 'jquery-ui-rails'
# end

group :test do
  gem 'tork'
  gem 'mocha'
  gem 'shoulda'
  gem 'test-unit'
end

# gem 'jquery-rails'
