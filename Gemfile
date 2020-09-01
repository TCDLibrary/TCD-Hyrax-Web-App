source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'activerecord-nulldb-adapter'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6.2'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
# JL : 18/12/2018 Moving from Sqlite to MySql
gem 'mysql2'

group :development, :test do
  # Use Puma as the app server
  gem 'puma', '~> 3.12'
end

group :dcdevhyrax, :digcollhyrax01, :digcollhyrax02 do
  # JL 07/03/2019 use Passenger instead of Puma
  gem "passenger", ">= 5.3.2", require: "phusion_passenger/rack_handler"
end
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
gem 'sidekiq'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
group :development do
  gem 'capistrano', '~> 3.12.0'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  #gem 'capistrano-rbenv'
  #gem 'capistrano-chruby'
  gem 'capistrano-bundler', '~> 2.0'
  #gem 'capistrano-rails/assets'
  #gem 'capistrano-rails/migrations'
  gem 'capistrano-passenger'
end

group :development, :test do
  # JL : removed on 16/03/2020: , :dcdevhyrax, :digcollhyrax01, :digcollhyrax02
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'capybara-screenshot'
  gem 'selenium-webdriver'
  gem 'webdrivers', '~> 3.0'
  # TODO: remove this when chrome updates beyond version 70:
  gem 'chromedriver-helper', '<= 2.45'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
group :development do
  gem 'spring'
##  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# gem 'hyrax', '2.7.2'
# temporarily use 2.x-stable to pick up Tom's Notch8 changes
#gem 'hyrax', git: 'https://github.com/samvera/hyrax', branch: '2.x-stable'
#gem 'hyrax', git: 'https://github.com/samvera/hyrax', branch: 'manifest-cache-key-backport'
#gem 'hyrax', git: 'https://github.com/samvera/hyrax', branch: 'versioned-file-id'
#gem 'hyrax', git: 'https://github.com/samvera/hyrax', branch: 'iiif-manifest-order-backport'
##>>gem 'hyrax', git: 'https://github.com/samvera/hyrax', branch: 'iiif-manifest-order-backport-ii'

gem 'hyrax', '2.9.0'

gem 'bulkrax', git: 'https://github.com/samvera-labs/bulkrax'

group :development, :test, :dcdevhyrax, :digcollhyrax01, :digcollhyrax02 do
# JL : removed on 16/03/2020 : , :dcdevhyrax, :digcollhyrax01, :digcollhyrax02
  gem 'solr_wrapper', '>= 0.3'
end

gem 'rsolr', '>= 1.0'
gem 'jquery-rails'
gem 'devise', '~> 4.7.1'
gem 'devise-guests', '~> 0.6'
group :development, :test do
# JL : removed on 16/03/2020 : , :dcdevhyrax, :digcollhyrax01, :digcollhyrax02
  gem 'fcrepo_wrapper'
  gem 'rspec-rails'
  gem 'database_cleaner'
end

gem 'riiif' #, '~> 1.1'

gem 'yaml_db'

# JL 10/04/2019 Added iso639 for language codes when building Dublin Core output
gem 'iso639'

# JL 17/07/2019 exifr to let me read image technical metadata
gem 'exifr'

# JL 11/10/2019 added to allow capistrano use sudo
gem 'sshkit-sudo'

# JL 04/11/2019 adding Admin users:
# https://github.com/samvera/hyrax/wiki/Making-Admin-Users-in-Hyrax
gem 'hydra-role-management'

gem 'willow_sword', github: 'notch8/willow_sword'

gem 'kaminari'
