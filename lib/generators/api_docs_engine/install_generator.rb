require 'rails/generators/base'
require 'securerandom'

module ApiDocsEngine
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      
      class_option :orm
      
      def copy_initializer
        template "api_docs_engine.rb", "config/initializers/api_docs_engine.rb"
      end
    end
  end
end
