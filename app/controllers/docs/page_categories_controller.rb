module Docs
  class PageCategoriesController < ::Docs::ApplicationController
    before_action :load_page_category, except: %i[index new create]
    include ManageResource
        
    def create
      super { redirect_to [resource, :pages] }
    end
    
    def update
      super { redirect_to [resource, :pages] }
    end
    
    private
    def permitted_params
      params.require(:page_category).permit(:slug, :title, :body)
    end
    
    def resource_params
      params.fetch :page_category, {}
    end
    
    def resource_class
      PageCategory
    end
  end
end