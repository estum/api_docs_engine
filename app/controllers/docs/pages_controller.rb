module Docs
  class PagesController < ::Docs::ApplicationController
    before_action :load_page_category, only: %i[index]
    before_action :load_page,          only: %i[show edit update destroy]
    include ManageResource
    
    def index
      @pages = @page_category.pages.order("via ASC, path ASC").sort_by &:weight
    end
    
    def new
      @page = build_resource
      @page.set_body_with_default_table
    end
    
    def edit
      super
      resource.set_body_with_default_table
    end
    
    def create
      @page = build_resource
      create! { redirect_to page_category_pages_path(@page.page_category) }
    end
    
    def update
      super { redirect_to page_category_pages_path(@page.page_category) }
    end
    
    def destroy
      super { redirect_to page_category_pages_path(@page.page_category) }
    end
    
    private
    def build_resource
      if params[:page_category_id].present?
        load_page_category
        @page_category.pages.build resource_params
      else
        Page.new resource_params
      end
    end
    
    def permitted_params
      params.require(:page).permit(:path, :via, :title, :body, :example, :reqs, :page_category_slug, :weight)
    end
    
    def resource_params
      params.fetch :page, {}
    end
    
    def resource_class
      Page
    end
  end
end