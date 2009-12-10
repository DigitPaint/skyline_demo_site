class NewsItem < Skyline::Article
  class Data < Skyline::Article::Data
    set_table_name "news_item_data"
    
    include Skyline::Taggable
    include Skyline::ContentItem     
    include Skyline::Referable  
    
    has_one :news_item, :foreign_key => "published_publication_data_id", :class_name => "NewsItem"
  
    validates_presence_of :title, :url_part, :if => :to_be_published  
    # validates_uniqueness_of :url_part, :if => :to_be_published  
    
    named_scope :published, lambda{
      {:include => [:news_item], :conditions => "skyline_articles.published_publication_data_id = news_item_data.id"}
    }
    
    # Default scope for site
    default_scope :order => "news_item_data.publication_date DESC"
    
    referable_content :image
  
    referable_field :teaser, :body
      
    def publication_date
      self[:publication_date].present? ? self[:publication_date] : Date.today
    end
  end    
  
  include Skyline::SearchableItem
  
  searchable_field :title => lambda{|article| article.published_publication_data.title},
                   :url => :url,
                   :documentdate => lambda{|article| article.published_publication.updated_at.to_time.utc.iso8601(3)},
                   :body => lambda{|article| article.published_publication.to_text}
    
  # Default scope for Skyline
  default_scope :include => :default_variant_data, :order => "news_item_data.publication_date DESC"
  
  def preview_wrapper_page
     Settings.get_page(:content, :news_item_detail_page_id)
   end
  
  def title
    "#{I18n.l(self.default_variant_data.publication_date, :format => :default)} #{self.default_variant_data.title}"
  end
  
  def url
    if p = Settings.get_page(:content, :news_item_detail_page_id)
      "#{p.url}/#{self.url_part}"
    else
      nil
    end
  end
  
end