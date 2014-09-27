require 'rails/generators/base'

module ApiDocsEngine
  module Generators
    class ApiDocsEngineGenerator < Rails::Generators::Base
      hook_for :orm
      
      namespace "api_docs_engine"
      source_root File.expand_path("../templates", __FILE__)
    end
  end
end