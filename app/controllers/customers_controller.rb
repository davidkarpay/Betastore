class CustomersController < ApplicationController
  skip_before_filter  :require_log_in, only: [:new, :create]

  def new
    @customer = Customer.new
    @page_title = "Sign up for an account"
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to products_path
    else
      render 'new'
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end

end
