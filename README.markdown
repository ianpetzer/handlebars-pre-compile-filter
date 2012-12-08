# Rake::Pipeline::Web::Filters::HandlebarsPreCompileFilter [![Build Status](https://secure.travis-ci.org/atsjj/handlebars-pre-compile-filter.png?branch=master)](http://travis-ci.org/atsjj/handlebars-pre-compile-filter)

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

##Go from this:
```javascript
<h1 class="title">{{title}}</h1>
```

##To this:
```javascript
Ember.TEMPLATES['test'] = Ember.Handlebars.template(function anonymous(Handlebars, depth0, helpers, partials, data) {
    helpers = helpers || Ember.Handlebars.helpers;
    var buffer = '',
        stack1, stack2, stack3, stack4, tmp1, self = this,
        functionType = "function",
        helperMissing = helpers.helperMissing,
        undef = void 0,
        escapeExpression = this.escapeExpression;
    data.buffer.push("\"<h1 class=\\\"title\\\">");
    stack1 = depth0;
    stack2 = "title";
    stack3 = {};
    stack4 = "true";
    stack3['escaped'] = stack4;
    stack4 = helpers._triageMustache || depth0._triageMustache;
    tmp1 = {};
    tmp1.hash = stack3;
    tmp1.contexts = [];
    tmp1.contexts.push(stack1);
    tmp1.data = data;
    if (typeof stack4 === functionType) {
        stack1 = stack4.call(depth0, stack2, tmp1);
    } else if (stack4 === undef) {
        stack1 = helperMissing.call(depth0, "_triageMustache", stack2, tmp1);
    } else {
        stack1 = stack4;
    }
    data.buffer.push(escapeExpression(stack1) + "</h1>\"");
    return buffer;
});
```

Wow.
