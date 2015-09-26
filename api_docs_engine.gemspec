# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.push(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = "api_docs_engine"
  s.version     = "0.1.3"
  s.authors     = ["Tõnis Simo"]
  s.email       = ["anton.estum@gmail.com"]
  s.summary     = "API documentation engine for Rails 4"
  s.description = "API documentation engine for Rails 4 with Postgres and Bootstrap"
  s.homepage    = "https://github.com/estum/api_docs_engine"
  s.license     = "MIT"
  
  s.files = Dir["{app,config,db,lib}/**/*"]
  # s.test_files = Dir["test/**/*"]
  
  s.add_dependency 'rails', '>= 4', '< 5'
  
  s.add_dependency 'redcarpet', '>= 3.1.2', '< 4'
  s.add_dependency 'friendly_id', '>= 5.0.0'
  s.add_dependency 'turbolinks', '>= 2.3.0'
  s.add_dependency 'formtastic', '>= 2.3.0'
  s.add_dependency 'slim-rails', '>= 2.0.0'
  
  s.add_dependency 'coffee-rails', '>= 3'
  s.add_dependency 'sass-rails', '>= 3'
  
  s.add_dependency 'jquery-rails'
  s.add_dependency 'bootstrap-sass', '>= 3', "< 4"
  s.add_dependency 'formtastic-bootstrap', '~> 3'
  s.add_dependency 'font-awesome-rails', '>= 4', '< 5'
end
