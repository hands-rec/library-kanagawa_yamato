# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'library/kanagawa_yamato/version'

Gem::Specification.new do |spec|
  spec.name          = "library-kanagawa_yamato"
  spec.version       = Library::KanagawaYamato::VERSION
  spec.authors       = ["hands-rec"]
  spec.email         = ["hands.records@gmail.com"]

  spec.summary       = %q{library in kanagawa yamato city}
  spec.description   = %q{library in kanagawa yamato city}
  spec.homepage      = ""

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "selenium-webdriver"
  spec.add_dependency "rack", "~> 2.x"
  spec.add_dependency "poltergeist"
  spec.add_dependency "capybara"
  spec.add_dependency "nokogiri"
end
