source "http://rubygems.org"

gemspec


group :development, :test do
  gem 'rspec', "~>2.5.0"
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec'
  gem 'growl' if RUBY_PLATFORM =~ /darwin/i
end
