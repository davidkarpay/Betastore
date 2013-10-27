class ApplicationController < ActionController::Base
  before_filter :require_log_in

  protected
  def require_log_in
    redirect_to '/log_in' unless logged_in?
  end

  def logged_in?
    cookies[:email].present?
  end
end
