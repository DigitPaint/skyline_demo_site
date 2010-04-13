module ShopHelper
  def total_price(order)
    total_price = 0
    order.order_products.each do |op|
      total_price += op.price * op.amount
    end
    total_price
  end
end