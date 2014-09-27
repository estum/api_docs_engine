module Docs
  class MissingDocsController < ::Docs::ApplicationController
    def index
      @missing_docs = MissingCollection.new.routes
    end
  end
end