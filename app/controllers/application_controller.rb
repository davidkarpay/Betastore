class ApplicationController < ActionController::Base
  before_filter :require_log_in

  protected
  def require_log_in
    redirect_to '/log_in' unless logged_in?
  end

  helper_method :logged_in?
  def logged_in?
    cookies.signed[:customer_id].present?
  end
end
