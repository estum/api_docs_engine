module Docs
  class MissingCollection < RoutesCollection
    def initialize(*args)
      super(*args)
      existed_pages = Page.all.to_a
      routes.select! do |route|
        existed_pages.detect do |p| 
          p.reqs == route.reqs && p.path == route.path
        end.nil?
      end
    end
  end
end