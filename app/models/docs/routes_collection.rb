module Docs
  class RoutesCollection
    include Enumerable
    attr_reader :routes
    
    def initialize(filter = nil)
      filter ||= Docs.missing_routes_filter
      @routes = Inspector.new(Rails.application.routes.routes).enumerate(filter)
    end
    
    def [](name)
      routes[name]
    end
    
    def each(&block)
      routes.each(&block)
      self
    end
    
    def by_controller
      routes.group_by(&:controller)
    end
    
    class Item
      attr_accessor :path, :via, :reqs, :pattern, :controller, :action
      
      def initialize(route)
        @path    = route.path.sub(/\(\.:format\)$/, '.json')
        @via     = route.verb
        @reqs    = route.reqs
        @pattern = route.json_regexp
        @controller, @action = reqs.split("#")
      end
      
      def to_page_attributes
        { path: path, via: via, reqs: reqs, page_category_slug: controller[/^api\/(\w+)/, 1] }
      end
      
      def inspect
        "#{via} #{path} => #{reqs}"
      end
    end
    
    class Inspector < ::ActionDispatch::Routing::RoutesInspector    
      def enumerate(filter = nil)
        routes_to_display = filter_routes(filter)
        collect_routes(routes_to_display)
      end
    
      private
      def filter_routes(filter)
        if filter
          @routes.select { |route| route.defaults[:controller] =~ filter }
        else
          @routes
        end
      end
    
      def collect_routes(routes)
        routes.collect do |route|
          ActionDispatch::Routing::RouteWrapper.new(route)
        end.reject do |route|
          route.internal?
        end.collect do |route|
          collect_engine_routes(route)
          Item.new(route)
        end
      end
    end
  end
end