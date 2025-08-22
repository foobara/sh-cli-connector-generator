require_relative "version"

source "https://rubygems.org"
ruby Foobara::Generators::ShCliConnectorGenerator::MINIMUM_RUBY_VERSION

gemspec

# gem "foobara", path: "../foobara"

gem "rake"

group :development do
  gem "foobara-rubocop-rules", ">= 1.0.0"
  gem "guard-rspec"
  gem "rubocop-rake"
  gem "rubocop-rspec"
end

group :development, :test do
  gem "pry"
  gem "pry-byebug"
  # TODO: Just adding this to suppress warnings seemingly coming from pry-byebug. Can probably remove this once
  # pry-byebug has irb as a gem dependency
  gem "irb"
end

group :test do
  gem "foobara-spec-helpers", "< 2.0.0"
  gem "rspec"
  gem "rspec-its"
  gem "simplecov"
end
