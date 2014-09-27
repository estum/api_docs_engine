require 'slim-rails'
require 'sass-rails'
require 'jquery-rails'
require 'coffee-rails'
require 'bootstrap-sass'
require "font-awesome-rails"
require 'redcarpet'
require 'friendly_id'
require 'formtastic'
require 'formtastic-bootstrap'
require 'turbolinks'

module Docs
  mattr_accessor :root_path
  @@root_path = "missing_docs#index"
  
  mattr_accessor :missing_routes_filter
  @@missing_routes_filter = /api\/.*/
  
  mattr_accessor :api_docs_prefix
  @@api_docs_prefix = "api"
  
  mattr_accessor :auth_module
  @@auth_module = nil
  
  def self.setup
    yield self
  end
  
  def self.route(router)
    router.instance_exec do
      root Docs.root_path
  
      resources :missing_docs,    only: [:index]    
      resources :page_categories, except: [:index, :show, :edit]
      resources :pages,           except: [:index, :show]
  
      resources :page_categories, shallow: true, path: Docs.api_docs_prefix, only: [:edit] do
        resources :pages, only: [:index, :new, :create], path: "", path_names: { new: "new_page" }
      end
      
      resources :markdown, only: "create"
    end
  end
end