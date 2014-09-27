require "docs/core_ext"

module Bootstrap
  module ActiveLinkTo
    class ActiveLink
      ACTIVE_OPTIONS = [:active, :class_active, :class_inactive, :active_disable]
    
      def initialize(context)
        @context = context
      end
    
      def render(*args, &block)
        @name           = block_given? ? capture(&block) : args.shift
        @link_options   = args.extract_options!
        @url            = h.url_for(args.shift)
        @active_options = @link_options.extract!(*ACTIVE_OPTIONS).only_presented
        @after_link     = @link_options.delete(:after_link).to_s
        
        if is_wrap?
          provide_wrap_with_content!
        else
          @link_options.smart_append_to :class, active_class
          content
        end
      end
    
      private
      def content
        "#{link}#{@after_link}".html_safe
      end
    
      def h
        @context
      end
    
      def link
        return @name if is_active? && is_active_disable?
        h.link_to @name, @url, @link_options
      end
    
      def is_active?
        @is_active = h.is_active_link?(@url, @active_options[:active]) if @is_active.nil?
        @is_active
      end
    
      def is_wrap?
        !@link_options[:wrap_tag].nil?
      end
    
      def is_dropdown?
        !@link_options[:dropdown].nil?
      end
    
      def is_active_disable?
        !!@active_options[:active_disable]
      end
    
      def provide_wrap_with_content!
        @link_options[:wrap_options] ||= {}
        @wrap_options, wrap_tag = @link_options.extract!(:wrap_options, :wrap_tag).values
        @wrap_options.smart_append_to :class, active_class
      
        provide_dropdown! if is_dropdown?
      
        h.content_tag wrap_tag, content, @wrap_options
      end
    
      def provide_dropdown!
        dropdown_html, dropdown = @link_options.extract!(:dropdown_html, :dropdown).values
        @wrap_options.smart_append_to :class, 'dropdown'
        @link_options.smart_update class: ['dropdown-toggle'], id: dropdown, data: {toggle: 'dropdown', hover: 'dropdown'}
        @after_link << dropdown_html.to_s
      end
    
      def active_class
        h.active_link_to_class(@url, @active_options, is_active?)
      end
    end
  
    # Wrapper around link_to. Accepts following params:
    #   :active         => Boolean | Symbol | Regex | Controller/Action Pair
    #   :class_active   => String
    #   :class_inactive => String
    #   :disable_active => Boolean
    #   :wrap_tag       => Symbol
    # Example usage:
    #   active_link_to('/users', :class_active => 'enabled')
    #   active_link_to(users_path, :active => :exclusive, :wrap_tag => :li)
    def active_link_to(*args, &block)
      ActiveLink.new(self).render(*args, &block)
    end
  
    # Returns css class name. Takes the link's URL and its params
    # Example usage:
    #   active_link_to_class('/root', :class_active => 'on', :class_inactive => 'off')
    #
    def active_link_to_class(url, options={}, is_active=nil)
      is_active = is_active_link?(url, options[:active]) if is_active.nil?
      is_active ? (options[:class_active] ||= 'active') : options[:class_inactive]
    end

    # Returns true or false based on the provided path and condition
    # Possible condition values are:
    #                  Boolean -> true | false
    #                   Symbol -> :exclusive | :inclusive
    #                    Regex -> /regex/
    #   Controller/Action Pair -> [[:controller], [:action_a, :action_b]]
    # Example usage:
    #   is_active_link?('/root', true)
    #   is_active_link?('/root', :exclusive)
    #   is_active_link?('/root', /^\/root/)
    #   is_active_link?('/root', ['users', ['show', 'edit']])
    #
    def is_active_link?(url, condition = nil)
      url = url_for(url).sub(/\?.*/, '') # ignore GET params
      case condition
      when :inclusive, nil
        !request.fullpath.match(/^#{Regexp.escape(url)}(\/.*|\?.*)?$/).blank?
      when :exclusive
        !request.fullpath.match(/^#{Regexp.escape(url)}\/?(\?.*)?$/).blank?
      when Regexp
        !request.fullpath.match(condition).blank?
      when Array
        controllers = [*condition[0]]
        actions     = [*condition[1]]
        (controllers.blank? || controllers.member?(params[:controller])) &&
        (actions.blank? || actions.member?(params[:action]))
      when TrueClass
        true
      when FalseClass
        false
      end
    end
  end
end