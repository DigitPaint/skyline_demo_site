class OrdersController < ApplicationController
  before_filter :find_page
  
  def update
    @order = Order.current_order(session[:order_id])
    
    if params[:product_id].present?
      product = Product.find(params[:product_id]).andand.published_publication
    
      if product
        if op = @order.order_products.find_by_product_id(product.product.id)
          op.amount = params[:amount].present? ? params[:amount].to_i : op.amount + 1
          op.amount <= 0 ? op.destroy : op.save
        else
          @order.products << product.product 
          @order.save
        end
        session[:order_id] = @order.id
      end
    
      redirect_to :action => "edit"
    else
      if @order.update_attributes(params[:order])
        session.delete :order_id
        render_on_page :template => "orders/confirmation", :title => "Thank you"
        
      else
        @confirm = true
        render_on_page :template => "orders/edit", :title => "Order details"
      end
    end
  end
  
  def edit
    @order = Order.current_order(session[:order_id])
    @confirm = params[:status] == "confirm" ? true : false
    
    render_on_page :title => "Shopping basket"
  end
  
  protected
  def find_page
    @page = Settings.get_page(:shop,:shop_page_id)
    @page_version = @page.andand.published_publication
    @skip_sections = true
    return redirect_to("/") unless @page_version
  end
  
  def render_on_page(*args)
    options = args.extract_options!
    renderer = Skyline::Site.new.renderer(:controller => self)
    
    renderer.assigns[:skip_sections] = true if @skip_sections
    renderer.assigns[:title] = options[:title] if options[:title]
    renderer.assigns[:no_basket] = true
    
    renderer.assigns[:body] = render_to_string options
        
    render :text => renderer.render(@page_version)
  end
end