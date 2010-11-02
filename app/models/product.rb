class Product < Skyline::Article
  class Data < Skyline::Article::Data
    set_table_name "product_data"
    
    include Skyline::Taggable
    include Skyline::BelongsToReferable
    include Skyline::HasManyReferablesIn
    
    has_one :product, :foreign_key => "published_publication_data_id", :class_name => "Product"
    
    has_many :order_products
    has_many :orders, :through => :order_products
    
  
    validates_presence_of :title, :url_part, :if => :to_be_published  
    
    before_validation :sanitize_url_part
    validate :validate_url_part, :if => :to_be_published
    
    named_scope :published, lambda{
      {:include => [:product], :conditions => "skyline_articles.published_publication_data_id = product_data.id"}
    }
    
    # Default scope for site
    default_scope :order => "product_data.title ASC"
    
    belongs_to_referable :image
  
    has_many_referables_in :teaser
    
    protected
    def sanitize_url_part
      self.url_part = self.url_part.to_s.downcase.gsub(/[^a-z0-9\.\-\+_]/,"_").squeeze("_") if self.url_part
    end

    def validate_url_part
      if self.url_part.blank?
        self.errors.add :url_part, :blank 
      else
        if match = Product.find_by_url_part(self.url_part)
          self.errors.add :url_part, :taken  if match != self.version.article
        end
      end      
    end
  end
  
  # Default scope for Skyline
  default_scope :include => :default_variant_data, :order => "product_data.title ASC"
  
  def preview_wrapper_page
    Settings.get_page(:shop, :product_detail_page_id)
  end
  
  def title
    "#{self.default_variant_data.title}"
  end
  
  def url
    if p = Settings.get_page(:shop, :product_detail_page_id)
      "#{p.url}/#{self.url_part}"
    else
      nil
    end
  end
  
end