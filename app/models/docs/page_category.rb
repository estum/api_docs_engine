module Docs
  class PageCategory < ActiveRecord::Base
    extend FriendlyId
    friendly_id :slug, use: :slugged
    has_many :pages
    alias_attribute :name, :title
    
    before_validation :set_missing_title, unless: :title?
    
    validates :slug, :title, presence: true
    validates :slug, uniqueness: true, on: :create
    
    def weight
      @weight ||= splitted_title[0].to_i.nonzero? || 100
    end
    
    def only_title
      @captures ||= splitted_title[1]
    end
    
    def splitted_title
      @splitted_title ||= title.match(/^(?:(\d+)\. )?(.+)$/).captures
    end
    
    private
    def set_missing_title
      self.title = slug.to_s.titleize
    end
  end
end