module Docs
  class PagesController < ::Docs::ApplicationController
    before_action :load_page_category, only: %i[index]
    before_action :load_page,          only: %i[show edit update destroy]
    
    def show
    end
    
    def index
      @pages = @page_category.pages.order("via ASC, path ASC").sort_by &:weight
    end
    
    def new
      @page = build_resource
      @page.set_body_with_default_table
    end
    
    def create
      @page = build_resource
      if @page.save
        redirect_to page_category_pages_path(@page.page_category)
      else
        render "new"
      end
    end
    
    def edit
      @page.assign_attributes(params.fetch(:page, {}))
      @page.set_body_with_default_table
    end
    
    def update
      if @page.update_attributes(page_params)
        redirect_to page_category_pages_path(@page.page_category)
      else
        render "edit"
      end
    end
    
    def destroy
      @page.destroy
      redirect_to page_category_pages_path(@page.page_category)
    end
    
    private
    def build_resource
      if params[:page_category_id].present?
        load_page_category
        @page_category.pages.build(params[:page])
      else
        Page.new(params[:page])
      end
    end
    
    def page_params
      params.require(:page).permit(:path, :via, :title, :body, :example, :reqs, :page_category_slug, :weight)
    end
  end
end