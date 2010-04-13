class Order < ActiveRecord::Base
  has_many :order_products
  has_many :products, :through => :order_products
  
  validates_presence_of :name, :address, :town, :country, :email, :if => :to_be_confirmed
  
  
  def self.current_order(order_id = nil)
    if order_id.present?
      order = self.find_by_id(order_id)
    else
      order = self.new 
    end
    order
  end
  
  private
  def to_be_confirmed
    self.status == "Confirmed"
  end
end