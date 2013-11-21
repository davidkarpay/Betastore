class Admin::ProductsController < ApplicationController
  before_action :set_admin_product, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show
    @orders = Order.all
  end

end
