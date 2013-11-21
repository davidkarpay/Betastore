class ProductsController < ApplicationController
  skip_before_filter :require_log_in

  def index
      @categories = Category.all

      scope = Product

      if params[:min_price].present?
        scope = scope.where('price >= ?', params[:min_price])
      end

      if params[:max_price].present?
        scope = scope.where('price <= ?', params[:min_price])
      end

      if params[:category_id].present?
        scope = scope.in_category(params[:category_id])
      end

      @products = scope.page(params[:page]).per(10)

    session[:view_count] ||= 0
    session[:view_count] += 1

    logger.debug "STATUS: #{params[:status]}"
    @page_title = "Products"

    respond_to do |format|
      format.html
      format.rss
      format.json do
        render json: @products
      end
    end

  end

  def create

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
    @product = Product.find(params[:id])
  end

  private
  def product_params
    params.require(:product).permit(:name, :price)
  end
end