require_relative "version"

Gem::Specification.new do |spec|
  spec.name = "test-org-test-domain"
  spec.version = TestOrg::TestDomain::VERSION
  spec.authors = ["Miles Georgi"]
  spec.email = ["azimux@gmail.com"]

  spec.summary = "Some test project"
  spec.homepage = "https://github.com/test-org/test-domain"
  spec.license = "MIT"
  spec.required_ruby_version = TestOrg::TestDomain::MINIMUM_RUBY_VERSION

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir[
    "lib/**/*",
    "src/**/*",
    "LICENSE.txt"
  ]

  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"
end
