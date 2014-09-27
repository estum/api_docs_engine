class ApiDocsCreate < ActiveRecord::Migration
  def up
    enable_extension :hstore

    create_table :docs_page_categories do |t|
      t.string :slug, index: { unique: true }
      t.string :title
      t.text :body
    end
    
    create_table :docs_pages do |t|
      t.belongs_to :page_category, index: true
      t.string :path
      t.string :via
      t.string :title
      t.text :body
      t.text :example
      t.hstore :data
    end
  end
  
  def down
    drop_table :docs_pages
    drop_table :docs_page_categories
    disable_extension :hstore    
  end
end