# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rake-pipeline-web-filters/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Steven Jabour"]
  gem.email         = ["atsjj@stevejabour.me"]
  gem.description   = <<-EOF
    Handlebars pre-compile filter does exactly that: 
    pre-compiles a handlebars template into javascript,
    so the client doesn't have to do all that work.

    Reduce execution time on your Handlebars utilizin' apps
    with this nifty gem. Best used with EmberJS!

    This is a sub-class to the existing HandlebarsFilter in
    the rake-pipeline-web-filters repo managed by Yehuda.
    https://github.com/wycats/rake-pipeline-web-filters

    This gem bundles the necessary Ember scripts to compile 
    templates headless-ly. Hopefully this allows you to
    be even lazier!
  EOF
  gem.summary       = %q{Magically turns a Handlebars template from a string into javascript.}
  gem.homepage      = "http://github.com/atsjj/handlebars-pre-compile-filter"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "handlebars-pre-compile-filter"
  gem.require_paths = ["lib"]
  gem.version       = Rake::Pipeline::Web::Filters::HBPCF_VERSION

  gem.add_dependency "rake-pipeline", "~> 0.6"
  gem.add_dependency "rake-pipeline-web-filters", "~> 0.7"
  gem.add_dependency "rack"
  
  gem.add_runtime_dependency "execjs"
  
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "handlebars-pre-compile-filter"
end
