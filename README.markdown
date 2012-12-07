# Rake::Pipeline::Web::Filters::HandlebarsPreCompileFilter [![Build Status](https://secure.travis-ci.org/atsjj/handlebars-pre-compile-filter.png?branch=master)](http://travis-ci.org/atsjj/handlebars-pre-compile-filter)

This project contains an extension to the HandlebarsFilter 
that helps to build a pre-compiled template.

Here's a quick example of a realistic project's Assetfile:

```ruby
# Assetfile.rb
require 'rake-pipeline-web-filters'
require 'handlebars-pre-compile-filter'

output "site"

input "templates" do
  match "**/*.handlebars" do
    filter HandlebarsPreCompileFilter
  end
end
```
