module Docs
  class MissingCollection < RoutesCollection
    def initialize(*args)
      super(*args)
      existed_pages = Page.all.to_a
      routes.select! do |r|
        existed_pages.detect {|p| p.reqs == r.reqs && p.path == r.path }.nil?
      end
    end
  end
end