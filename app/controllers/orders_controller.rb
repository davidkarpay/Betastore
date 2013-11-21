class OrdersController < ApplicationController
  skip_before_filter :require_log_in, only: [:new, :create]
  before_filter :set_default_status

  def new
  	@order = Order.new

    Hash(session[:cart]).each do |pid, qty|
      @order.line_items.build(
        product_id: pid,
        quantity: qty)
      end

    @title = "Checkout"
    @page_title = "Checkout"
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to root_path, notice: 'Your order has been placed'
    else
      flash.new[:alert] = @order.errors.full_messages.join(', ')
      logger.error "errors: #{@order.errors.full_messages.join(', ')}"
      render 'new'
    end
  end

  protected
  def order_params
    params.require(:order).permit(line_items_attributes: [:product_id, :quantity])
  end

  private
  def set_default_status
    if params[:status].blank?
      redirect_to url_for(:status => "blank")
    end
  end
end
