class PasswordResetsControllerController < ApplicationController
  skip_before_filter :require_log_in

  before_filter :check_token , only: [:edit, :update]

  def create
    customer = Customer.find_by(email: params[:email])
    if customer
      password_reset = customer.password_resets.build
      password_reset.save!   #put the '!' (bang) to show an error if it doesn't save
      redirect_to '/', notice: 'Check your email for instruction on how to reset your password.'
    else
      @error = 'could not find account'
      render 'new'
    end
  end

  def update
    if @password_reset.customer.update_attributes(password: params[:password])
      redirect_to log_in_path
    else
      render 'edit'
    end
  end

  protected

  def check_token
    @password_reset = PasswordReset.find_by(id: params[:id])
    unless @password_reset.try(:token) == params[:token]
      redirect_to forgot_password_path, alert: 'Your password reset link has expired.'
    end
  end


  #/reset_password/1/98y23jns9p8awhktnaw;jkdsfm

  #params[Id] == 1
  #params[:token] == 98y23jns9p8awhktnaw;jkdsfm

end

