source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.5.0'
# Use Puma as the app server
gem 'puma', '~> 6.0'


# Replacement for webpacker, going based on:
# https://github.com/rails/jsbundling-rails/blob/main/docs/switch_from_webpacker.md
gem 'cssbundling-rails'
gem 'jsbundling-rails'
gem 'stimulus-rails'
gem 'turbo-rails', "~> 1.0"

gem 'sprockets-rails', :require => 'sprockets/railtie'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'droplet_kit', '~> 3.0'
gem 'concode'
gem 'lograge'

# Sucker Punch for ActiveJob
gem 'sucker_punch', '~> 3.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 6.0'
  gem 'cucumber-rails', require: false
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'dotenv'
  gem 'sqlite3'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.8.1'
  # Spring costs developers more time than it saves, because it introduces many
  # new and surprising behaviors which we previously didn't have to deal with.
  # # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # # gem 'spring'
  # # gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'rails-controller-testing'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
