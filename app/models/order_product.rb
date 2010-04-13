class OrderProduct < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  
  before_save :update_order_product_fields
  
  def update_order_product_fields
      self.price = self.product.published_publication_data.price
      self.title = self.product.published_publication_data.title
      self.amount = 1 unless self.amount.present?
  end
end