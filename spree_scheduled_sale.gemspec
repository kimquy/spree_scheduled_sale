$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spree_scheduled_sale/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spree_scheduled_sale"
  s.version     = SpreeScheduledSale::VERSION
  s.authors     = ["Mike Porter"]
  s.email       = ["mikep@ricksteves.com"]
  s.summary     = "SpreeScheduledSale."
  s.description = "SpreeScheduledSale."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # s.add_dependency "rails", "~> 4.0.5"

end
