require "bootstrap/active_link_to"
require "bootstrap/markdown_renderer"

module Docs
  module ApplicationHelper
    include Bootstrap::ActiveLinkTo
    include FontAwesome::Rails::IconHelper
    
    def li_active_to(*args, &block)
      options = args.extract_options!
      if block_given?
        buffer = capture(&block)
        if options.has_key?(:dropdown)
          options[:dropdown_html] = buffer
        else
          args.unshift(buffer)
        end
      end
      options[:wrap_tag] = :li
      active_link_to *args, options
    end
    
    def li_link_to(*args, &block)
      options = args.last.is_a?(Hash) ? args.pop : {}
      url     = args.pop
      title   = args.pop unless block_given?
  
      link_options = options.delete(:link).presence || {}
      li_options   = { class: (%w(active) if current_page?(url)) }.smart_merge!(options.delete(:li).presence || {})
  
      link = block_given? ? link_to(url, link_options, &block) : link_to(title, url, link_options)
  
      content_tag :li, raw(link), li_options
    end
    
    def single_resource
      instance_variable_get "@#{controller_name.singularize}"
    end
    
    def markdown(text)
      renderer = Bootstrap::MarkdownRenderer.new(hard_wrap: true, filter_html: true)
      options = {
        autolink: true,
        fenced_code_blocks: true,
        superscript: true, 
        tables: true
      }
      Redcarpet::Markdown.new(renderer, options).render(text).html_safe
    end
  end
end