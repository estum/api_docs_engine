require "active_support/concern"

module Docs
  module ManageResource
    extend ActiveSupport::Concern
    
    included do      
      def collection
        instance_variable_get collection_var_name
      end
      
      def resource
        instance_variable_get resource_var_name
      end
      
      alias_method :single_resource, :resource
      helper_method :collection, :resource, :single_resource
    end
    
    def show
    end
    
    def index
      set_collection resource_class.all
    end
    
    def new
      set_resource resource_class.new(resource_params)
    end
    
    def edit
      resource.attributes = resource_params
    end
    
    def create(&block)
      set_resource resource_class.new(permitted_params)
      create!(&block)
    end
    
    def update(&block)
      update!(&block)
    end
    
    def destroy(&block)
      destroy!(&block)
    end
    
    private
    def create!(&block)
      if resource.save
        yield_or_redirect_to_root! &block
      else
        render "new"
      end
    end
    
    def update!(&block)
      if resource.update_attributes(permitted_params)
        yield_or_redirect_to_root! &block
      else
        render "edit"
      end
    end
    
    def destroy!(&block)
      resource.destroy
      yield_or_redirect_to_root! &block
    end
    
    def yield_or_redirect_to_root!
      if block_given?
        yield
      else
        redirect_to root_path
      end
    end
    
    def set_resource(new_resource)
      instance_variable_set resource_var_name, new_resource
    end
    
    def set_collection(new_collection)
      instance_variable_set collection_var_name, new_resource
    end
    
    def resource_var_name
      @resource_var_name ||= "@#{controller_name.singularize}"
    end
    
    def collection_var_name
      @collection_var_name ||= "@#{controller_name.pluralize}"
    end
    
    def resource_class
      controller_name.pluralize.classify.constantize
    end
  end
end