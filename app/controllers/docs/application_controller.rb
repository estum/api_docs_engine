module Docs
  class ApplicationController < ActionController::Base
    if Docs.auth_module.is_a?(Proc)
      Docs.auth_module.call(self)
    end
    
    protect_from_forgery
    layout 'docs/layouts/docs'
    before_filter :set_locale
  
    private
    def set_locale
      I18n.locale = "ru"
    end
    
    def load_page_category
      @page_category = PageCategory.friendly.find(params[:page_category_id].presence || params[:id])
    end
    
    def load_page
      @page = Page.find(params[:id])
    end
  end
end