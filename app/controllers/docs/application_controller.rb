module Docs
  class ApplicationController < ActionController::Base
    if Docs.auth.is_a? Proc
      Docs.auth.call(self)
    end
    
    protect_from_forgery
    layout 'docs/layouts/docs'
    before_filter :set_locale
    
    private
    def set_locale
      I18n.locale = I18n.default_locale
    end
    
    def load_page
      @page = Page.find params[:id]
    end
    
    def load_page_category
      @page_category = PageCategory.friendly.find(params[:page_category_id].presence || params[:id])
    end
  end
end