module Rake::Pipeline::Web::Filters
  class HandlebarsPreCompileFilter < HandlebarsFilter
    def initialize(options={}, &block)
      options = {
        :wrapper_proc => proc { |source|
          vendor = File.join File.dirname(__FILE__), "..", "..", "vendor"
          contents = [File.read("#{vendor}/headless-ember.js"), File.read("#{vendor}/ember.js")].join("\n")
          context = ExecJS.compile(contents)
          template = context.call("precompileEmberHandlebars", source)
          "Ember.Handlebars.template(#{template});"
        }
      }.merge(options)
      super(options, &block)
    end
    
    private 

    def external_dependencies
      [ 'execjs' ]
    end
  end
end
