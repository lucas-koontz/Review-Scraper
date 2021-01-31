lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative "lib/review_scraper/version"

Gem::Specification.new do |spec|
  spec.name          = "review_scraper"
  spec.version       = ReviewScraper::VERSION
  spec.authors       = ["Lucas Koontz"]
  spec.email         = ["lucas.emanuel19@gmail.com"]

  spec.summary       = "Review Scraper."
  spec.description   = "This web scraper searches for \"good\" dealership's reviews on DealerRater.com for the Committee for State Security."
  spec.homepage      = "https://github.com/lucasfernand-es/Review-Scraper"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/lucasfernand-es/Review-Scraper"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
