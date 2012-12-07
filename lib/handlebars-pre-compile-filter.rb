require "rake-pipeline"

module Rake
  class Pipeline
    module Web
      module Filters
      end
    end
  end
end

require "handlebars-pre-compile-filter/version"
require "handlebars-pre-compile-filter/handlebars_pre_compile_filter"
