module Docs
  class Page < ActiveRecord::Base
    belongs_to :page_category, autosave: true
    store_accessor :data, :notice, :reqs, :weight
    
    default_value_for :via, "GET"
    
    before_validation :upcase_via, if: :via?
    
    validates :path, :via, :title, presence: true
    
    def weight
      super.to_i
    end
    
    def method_path
      @method_path ||= [via, only_path].join(" ")
    end
    
    def page_category_slug
      @page_category_slug ||= page_category.try(:slug)
    end
    
    def page_category_slug=(slug)
      @page_category_slug = begin
        slug = slug.to_s.downcase.underscore
        self.page_category = PageCategory.find_or_initialize_by(slug: slug)
        page_category.try(:slug)
      end
    end
    
    def anchor
      @anchor ||= method_path.downcase.gsub(/[^\w]/, "_")
    end
    
    def only_path
      @only_path ||= path.split("?").first
    end
    
    def only_query
      @only_query ||= splitted_path.length > 1 ? "?#{splitted_path.last}" : ""
    end
    
    def splitted_path
      @splitted_path ||= path.split('?')
    end
    
    def set_body_with_default_table
      return body if body.present?
      self.body = <<-markdown.gsub(/^\s+\.|/, '')
        .| Параметр | Описание |
        .|----------|----------|
        .|          |          |
        .
        .
      markdown
    end
    
    private
    def upcase_via
      via.upcase!; true
    end
  end
end