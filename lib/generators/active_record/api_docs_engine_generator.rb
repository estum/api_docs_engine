require 'rails/generators/active_record'
require 'generators/api_docs_engine/orm_helpers'

module ActiveRecord
  module Generators
    class ApiDocsEngine < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      include ::ApiDocsEngine::Generators::OrmHelpers

      def copy_api_docs_engine_migration
        migration_template "migration.rb", "db/migrate/api_docs_create.rb"
      end
    end
  end
end
