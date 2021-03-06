source 'https://rubygems.org'
ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'

gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# フロント
gem 'honoka-rails'
gem 'simple_form'
gem 'i18n_generators'
gem 'kaminari'
gem 'kaminari-i18n'

# ジオコーディング
gem 'geocoder'
gem 'geokit-rails'

# ユーザー登録
gem 'devise'
# gem 'devise-i18n'
gem 'validates_email_format_of'

group :development, :test do
  # excelの読み込み
  gem 'roo'
  gem 'seed-fu'
  # N+1問題の検出
  gem 'bullet'

  gem 'pry-rails'
  gem 'pry-coolline'
  gem 'pry-byebug'

  # Rspec
  gem 'rspec-rails'
  gem 'test-unit'
  gem 'rails-controller-testing'
  gem "factory_girl_rails", "~> 4.0"
  gem 'faker'
  gem 'ffaker'
  gem 'shoulda-matchers', '~> 3.1'

  gem 'dotenv-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'

  # IntelliJ IDEA デバッグ
  gem 'ruby-debug-ide'
  gem 'debase'

  gem 'annotate'
  gem 'better_errors'
end

gem "rails_12factor", group: :production
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
