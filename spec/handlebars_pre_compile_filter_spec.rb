describe "HandlebarsPreCompileFilter" do
  HandlebarsFilter ||= Rake::Pipeline::Web::Filters::HandlebarsPreCompileFilter
  MemoryFileWrapper ||= Rake::Pipeline::SpecHelpers::MemoryFileWrapper
  MemoryManifest ||= Rake::Pipeline::SpecHelpers::MemoryManifest

  let(:handlebars_input) {
    '<h1 class="title">{{title}}</h1>'
  }

  let(:expected_output) {
    "Ember.TEMPLATES['test']=Ember.Handlebars.template(\"function anonymous(Handlebars,depth0,helpers,partials,data) {\nhelpers = helpers || Ember.Handlebars.helpers;\n  var buffer = '', stack1, stack2, stack3, stack4, tmp1, self=this, functionType=\"function\", helperMissing=helpers.helperMissing, undef=void 0, escapeExpression=this.escapeExpression;\n\n\n  data.buffer.push(\"<h1 class=\\\"title\\\">\");\n  stack1 = depth0;\n  stack2 = \"title\";\n  stack3 = {};\n  stack4 = \"true\";\n  stack3['escaped'] = stack4;\n  stack4 = helpers._triageMustache || depth0._triageMustache;\n  tmp1 = {};\n  tmp1.hash = stack3;\n  tmp1.contexts = [];\n  tmp1.contexts.push(stack1);\n  tmp1.data = data;\n  if(typeof stack4 === functionType) { stack1 = stack4.call(depth0, stack2, tmp1); }\n  else if(stack4=== undef) { stack1 = helperMissing.call(depth0, \"_triageMustache\", stack2, tmp1); }\n  else { stack1 = stack4; }\n  data.buffer.push(escapeExpression(stack1) + \"</h1>\");\n  return buffer;\n}\");"
  }

  def input_file(name, content)
    MemoryFileWrapper.new("/path/to/input", name, "UTF-8", content)
  end

  def output_file(name)
    MemoryFileWrapper.new("/path/to/output", name, "UTF-8")
  end

  def setup_filter(filter, input_filename = "test.handlebars")
    filter.file_wrapper_class = MemoryFileWrapper
    filter.manifest = MemoryManifest.new
    filter.last_manifest = MemoryManifest.new
    filter.input_files = [input_file(input_filename, handlebars_input)]
    filter.output_root = "/path/to/output"
    filter.rake_application = Rake::Application.new
    filter
  end

  it "generates output" do
    filter = setup_filter HandlebarsFilter.new

    filter.output_files.should == [output_file("test.js")]

    tasks = filter.generate_rake_tasks
    tasks.each(&:invoke)

    file = MemoryFileWrapper.files["/path/to/output/test.js"]
    file.body.should == expected_output
    file.encoding.should == "UTF-8"
  end

  describe "naming output files" do
    it "translates .handlebars extensions to .js by default" do
      filter = setup_filter HandlebarsFilter.new, "test.handlebars"
      filter.output_files.first.path.should == "test.js"
    end

    it "translates .hbs extensions to .js by default" do
      filter = setup_filter HandlebarsFilter.new, "test.hbs"
      filter.output_files.first.path.should == "test.js"
    end

    it "accepts a block to customize output file names" do
      filter = setup_filter(HandlebarsFilter.new { |input| "squid" })
      filter.output_files.first.path.should == "squid"
    end
  end

  describe "options" do
    it "should allow an option to name the key" do
      filter = setup_filter(HandlebarsFilter.new(:key_name_proc => proc { |input| "new_name_key" }))
        
      tasks = filter.generate_rake_tasks
      tasks.each(&:invoke)

      file = MemoryFileWrapper.files["/path/to/output/test.js"]
      file.body.should =~ /^Ember\.TEMPLATES\['new_name_key'\]/
    end
  end
end
