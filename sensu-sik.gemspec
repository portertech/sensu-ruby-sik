lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sensu/sik/version"

Gem::Specification.new do |spec|
  spec.name          = "sensu-sik"
  spec.version       = Sensu::SIK::VERSION
  spec.authors       = ["Sean Porter"]
  spec.email         = ["portertech@gmail.com"]

  spec.summary       = "The Sensu Ruby SIK (Softare Instrumentation Kit)"
  spec.description   = "The Sensu Ruby SIK (Softare Instrumentation Kit)"
  spec.homepage      = "https://github.com/portertech/sensu-ruby-sik"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "statsd-instrument", "2.2.1"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
