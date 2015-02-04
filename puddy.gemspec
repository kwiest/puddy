$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "puddy/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "puddy"
  s.version     = Puddy::VERSION
  s.authors     = ["Kyle Wiest"]
  s.email       = ["kyle.wiest@gmail.co"]
  s.summary     = "Dashboard for Camp Registration Systems"
  s.description = "Dashboard for Camp Registration Systems"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.12"
  s.add_dependency "prawn", "~> 0.12.0"
  s.add_dependency "monetizable"
  s.add_dependency "state_machine", "~> 1.1.2"

  s.add_development_dependency "pg", "~> 0.16.0"
  s.add_development_dependency "shoulda", "~> 3.1.1"
end
