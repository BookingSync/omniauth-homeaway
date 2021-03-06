require File.expand_path("../lib/omniauth/homeaway/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name = "omniauth-homeaway"
  gem.version = OmniAuth::HomeAway::VERSION
  gem.platform = Gem::Platform::RUBY
  gem.authors = ["Sebastien Grosjean"]
  gem.email = ["dev@bookingsync.com"]
  gem.homepage = "https://github.com/bookingsync/omniauth-homeaway"
  gem.summary = "An OmniAuth strategy for HomeAway OAuth2 identification."
  gem.description = "An OmniAuth strategy for HomeAway OAuth2 identification."

  gem.executables = `git ls-files -- exe/*`.split("\n").map { |f| File.basename(f) }
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]

  gem.add_dependency "omniauth", "~> 1.6"
  gem.add_dependency "omniauth-oauth2", "<= 1.4"
  gem.add_dependency "oauth2", "~> 1.3.0"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rubocop"
  gem.add_development_dependency "appraisal"
end
