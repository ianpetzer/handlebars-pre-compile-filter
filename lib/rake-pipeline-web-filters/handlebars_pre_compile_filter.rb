module Rake::Pipeline::Web::Filters
  class HandlebarsPreCompileFilter < HandlebarsFilter
    def initialize(options={}, &block)
      @options = {
        :wrapper_proc => proc { |source|
          contents = [File.read("vendor/headless-ember.js"), File.read("vendor/ember.js")].join("\n")
          context = ExecJS.compile(contents)
          template = context.call("precompileEmberHandlebars", source)
          "Ember.Handlebars.template(#{template});"
        }
      }
      
      super(options, &block)
    end
    
    private 

    def external_dependencies
      [ 'execjs' ]
    end
  end
end
