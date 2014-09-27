module Docs
  class Engine < ::Rails::Engine
    isolate_namespace Docs
    
    initializer "docs.asset_precompile_paths" do |app|
      app.config.assets.precompile += %w(docs.*)
    end
  end
end