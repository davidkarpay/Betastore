class ProductsController < ApplicationController
  skip_before_filter :require_log_in

  def index

    logger.debug "STATUS: #{params[:status]}"
    @page_title = "Products"
    @products = Product.all

    respond_to do |format|
      format.html
      format.rss
      format.json do
        render json: @products
      end
    end

  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html do
          redirect_to product_path(@product), notice: 'Product was saved!'
       end
      format.json do
          render json: @product
        end
      else
        format.html do
          render 'edit'
        end
        format.json do
          render json: {errors: @product.errors }, status: 442
        end
      end
    end
  end

  def show
  end

  private
  def product_params
    params.require(:product).permit(:name, :price)
  end
end