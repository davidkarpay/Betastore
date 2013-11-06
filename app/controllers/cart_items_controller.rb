class CartItemsController < ApplicationController
  skip_before_filter :require_log_in

  def index                           #if it's nil, make it a Hash.
    @cart_items = Hash(session[:cart]).map do |pid, qty| #need to set up an array for this object. The data for this array will be a hash in the session...
      product = Product.find(pid)
      CartItem.new(product, qty)                         #now we have the product id and quantity (searched in the rails dbconsole)
      respond_to do |format|
        format.html do
          redirect_to products_path, notice: "Product #{params[:product_id]} was added to your cart"
        end
        format.json do
          render json: {
              cart: session[:cart],
              item_count: session[:cart].values.sum
          }
        end
      end
    end
    render layout: !request.xhr?   #If it's an ajax request, then layout should be false. If it's not an ajax request,
            # then the layout should be true.    XHR = XHTMLHTTPRequest.
  end                                     #.map is a method called on Array objects.

  def create

    session[:cart] ||= Hash.new(0)
    session[:cart][params[:product_id]] += 1
    respond_to do |format|
      format.html do
        redirect_to products_path, notice: "Product #{params[:product_id]} was added to your cart."
      end
      format.json do
        render json: {
            cart: session[:cart],
            item_count: session[:cart].values.sum
        }
      end

    end
  end
end
