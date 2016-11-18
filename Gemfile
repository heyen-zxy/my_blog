#source 'https://rubygems.org'
#source 'https://ruby.taobao.org'
source 'https://gems.ruby-china.org'

ruby '2.3.0'

source 'https://rails-assets.org' do
  gem 'rails-assets-font-awesome', '~> 4.3.0'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
 gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  #测试
  gem 'rspec'
  #测试数据辅助
  gem 'factory_girl'
  #项目部署
  gem 'mina'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
#bootstrap
gem 'bootstrap-sass', '~> 3.3.6'  #gem 'rails-assets-bootstrap'
#gem 'font-awesome-rails', '~> 4.3.0' #gem 'rails-font-awesome'
#attributes辅助
gem 'annotate'
#服务器
gem 'puma'
#分页
gem 'kaminari'
#配置config
gem 'config'
#假删除
gem "paranoia", "~> 2.2.0.pre"
#dedis
gem 'redis', '~>3.2'
#I18n
gem 'rails-i18nterface'

group :production do
  gem 'mysql2', "~> 0.3.11"
end


#markdown
gem 'redcarpet'
gem 'coderay'

#登录管理
gem 'devise'

#api
gem 'grape'


