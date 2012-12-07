# -*- encoding: utf-8 -*-
require File.expand_path('../lib/handlebars-pre-compile-filter/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Steven Jabour"]
  gem.email         = ["atsjj@stevejabour.me"]
  gem.description   = %q{An extension to HandlebarsFilter that helps to pre-compile Handlebar templates.}
  gem.summary       = %q{An extension to HandlebarsFilter that helps to pre-compile Handlebar templates.}
  gem.homepage      = "http://github.com/atsjj/handlebars-pre-compile-filter"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "handlebars-pre-compile-filter"
  gem.require_paths = ["lib"]
  gem.version       = Rake::Pipeline::Web::Filters::HBPCF_VERSION

  gem.add_dependency "rake-pipeline", "~> 0.6"
  gem.add_dependency "rack"
  gem.add_development_dependency "therubyracer"
end
