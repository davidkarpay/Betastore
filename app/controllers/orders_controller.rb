class OrdersController < ApplicationController
  skip_before_filter :require_log_in
  before_filter :set_default_status

  def new
  	@title = "Checkout"
    @page_title = "Checkout"
  end

  private
  def set_default_status
    if params[:status].blank?
      redirect_to url_for(:status => "blank")
    end
  end
end
