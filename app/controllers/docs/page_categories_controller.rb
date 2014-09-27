module Docs
  class PageCategoriesController < ::Docs::ApplicationController
    before_action :load_page_category, except: %i[index new create]
    
    def show
    end
    
    def index
      @page_categories = PageCategory.all
    end
    
    def new
      @page_category = PageCategory.new(params[:page_category])
    end
    
    def create
      @page_category = PageCategory.new(page_category_params)
      if @page_category.save
        redirect_to [@page_category, :pages]
      else
        render "new"
      end
    end
    
    def edit
      @page_category.assign_attributes(params.fetch(:page_category, {}))
    end
    
    def update
      if @page_category.update_attributes(page_category_params)
        redirect_to [@page_category, :pages]
      else
        render "edit"
      end
    end
    
    def destroy
      @page_category.destroy
    end
    
    private
    def page_category_params
      params.require(:page_category).permit(:slug, :title, :body)
    end
  end
end