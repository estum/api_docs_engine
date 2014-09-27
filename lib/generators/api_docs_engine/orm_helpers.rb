module ApiDocsEngine
  module Generators
    module OrmHelpers
      private
      def migration_path
        @migration_path ||= File.join("db", "migrate")
      end
    end
  end
end
