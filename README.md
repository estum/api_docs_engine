# API documentation engine for Rails 4

The ApiDocsEngine provides simple UI to manage API documentation for your application. Documentation stored in db (currently only supports PostgreSQL >= 9.2) with Markdown syntax. UI uses Bootstrap, Turbolinks and Highlight.js.

Currently gem is very raw and needs more documentation.

## Installation

Add this line to your application's Gemfile:

    gem 'api_docs_engine'

And then execute:

    $ bundle

Generate migrations:

    $ rails g api_docs_engine docs
    $ rake db:migrate

Generate initializer:

    $ rails g api_docs_engine:install

### Using with BootInquirer

Note: You shouldn't add `'api_docs_engine'` to your application's Gemfile.

* Create new `docs` engine
* Add `spec.add_dependency 'api_docs_engine'` to `docs.gemspec`
* Ad following code in your `%engines_path%/docs/lib/docs.rb`:

```ruby
require "api_docs_engine/docs"

Docs.setup do |config|
  # config.title = "API documentation"
  # config.root_path = { to: "pages#index", defaults: { page_category_id: "common" }}
  # config.missing_routes_filter = /api\/.*/
  # config.api_docs_prefix = "api"
  # config.auth = Proc.new do |controller|
  #   controller.class_eval do
  #     http_basic_authenticate_with name: "admin", password: "admin", only: nil
  #   end
  # end
end

require "docs/engine"
```

## Usage

TODO: Write usage instructions here


## Contributing

1. Fork it ( https://github.com/[my-github-username]/api_docs_engine/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
