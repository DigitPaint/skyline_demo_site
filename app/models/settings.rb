class Settings < ActiveRecord::Base
  include Skyline::Settings
  include Skyline::BelongsToReferable
  
  referable_serialized_content  :news_items_overview_page,
                                :news_item_detail_page,
                                :shop_page,
                                :product_detail_page,
                                :calendar_items_overview_page,
                                :results_page,
                                :sitemap_page,
                                :error404_page
                                  
  page :content, :title => "Content pages" do |p|
    p.description "Settings for content pages."    
      
    p.field_group :news, :title => "News" do |g|  
      g.field :news_item_detail_page_id do |f|
        f.editor = :page_browser
        f.label = ["Detail",""]
        f.description = "The page used to display a news item."
      end
    end
    
    p.field_group :calendar, :title => "Agenda" do |g|
      g.field :calendar_items_overview_page_id do |f|
        f.editor = :page_browser
        f.label = ["agenda overzicht",""]
        f.description = "The page used for displaying the calendar."
      end        
    end
  end
  
  page :shop, :title => "Shop" do |p|
    p.description "Settings for shop."
    
    p.field :shop_page_id do |f|
      f.editor = :page_browser
      f.label = ["Shop items",""]
      f.description = "The page used to display pages related to the shop"
    end
    
    p.field :product_detail_page_id do |f|
      f.editor = :page_browser
      f.label = ["Shop items",""]
      f.description = "The page used to display a product"
    end
  end
    
  page :specials, :title => "Special pages" do |p|
    p.description "Settings for special pages"    
    
    p.field :sitemap_page_id do |f|
      f.editor = :page_browser
      f.label = ["Sitemap",""]
      f.description = "Page used for the sitemap. The sitemap will be rendered automatically on this page."
    end
    
    p.field :error404_page_id do |f|
      f.editor = :page_browser
      f.label = ["404",""]
      f.description = "Page used in case of a 404 error."
    end
  end
  
  page :fragments, :title => "Standard fragments" do |p|
    p.field :footer_fragment_id do |f|
      f.editor = :list
      f.list = Proc.new{|owner| [["-",nil]] + Skyline::PageFragment.ordered_by_title.all.map{|p| [p.default_variant_data.title, p.id.to_s]}}
      f.label = ["Footer",""]
      f.description = "This fragment will be used as the footer."
    end
  end
end
