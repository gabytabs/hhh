source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rack-cors'
gem 'mechanize'
gem 'devise'
gem 'active_model_serializers'
gem 'knock'
gem 'pry-rails'


group :development, :test do
  gem 'rb-readline'
  gem 'pry-byebug'
  gem 'rspec-rails' #testing framework
  gem 'factory_girl_rails' #'sample data' that populates your testing database before your tests run.
  gem 'guard-rspec' #works together with guard in order to run specs automatically
  gem 'guard'
  gem 'rails-controller-testing' #test controllers
  gem 'faker' #generates 'fake' data which can be used for testing or development (seeds)
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  #Launchy opens your default web browser on demand to show you what your application is rendering and
  #is very useful for feature tests!
  gem 'database_cleaner' #cleans data from database when you run your specs
  gem 'capybara', '~> 2.13' #helps to test your web app by simulating how a user would interact with the app
  gem 'selenium-webdriver' #can test JavaScript-based browser interactions with Capybara.
  gem 'shoulda-matchers', '~> 3.1' #one-liners that test common Rails functionality.
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
