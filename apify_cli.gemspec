# frozen_string_literal: true

require_relative "lib/apify/version"

Gem::Specification.new do |spec|
  spec.name        = "apify_cli"
  spec.version     = Apify::VERSION
  spec.authors     = ["Sead Feng"]
  spec.email       = ["seadfeng@icoud.com"]
  spec.homepage    = "https://github.com/seadfeng/apify_cli"
  spec.summary     = "Apify Client"
  spec.description = "Apify Client"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/seadfeng/apify_cli"
  spec.metadata["changelog_uri"] = "https://github.com/seadfeng/apify_cli/CHANGELOG.MD"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rest-client"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
