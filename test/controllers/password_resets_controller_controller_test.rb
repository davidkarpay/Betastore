require 'test_helper'

class PasswordResetsControllerControllerTest < ActionController::TestCase
 test "forgot password form" do
   get :new         #new is the name of the action that we will be testing
   assert_response :success
   Rails.logger.debug @response.body
   assert_select 'form[action=/forgot_password]'
   assert_select 'input[name=email]' # is there input on the page with an attribute
            #called email (the attribute's name is 'email')

 end

 test "forgot password with existing email" do   #hmm let's fix this.
    assert_difference 'PasswordReset.count' do   #make sure that the PasswordReset counts increased by 1
      post :create, email: customers(:test).email
    end
    assert_redirected_to '/'
    mail = ActionMailer::Base.deliveries.last
    assert mail, 'No email was sent'
    assert_equal [customers(:test).email], mail.to
    assert_equal "Password Reset Instructions", mail.subject
 end

 test "forgot password with non-existent email" do   #hmm let's fix this.
   assert_no_difference 'PasswordReset.count' do   #make sure that the PasswordReset counts increased by 1
     post :create, email: 'fail@example.com'
   end
   assert_response :success
   assert_select '.error'
 end


 test "edit with valid id and token" do
   get :edit, id: password_resets(:test).id,
       token: password_resets(:test).token
   assert_response :success
 end

 test "edit with invalid id" do
  get :edit, id: 0, token: 'fail'
  assert_redirected_to forgot_password_path
 end


 test "edit with valid id and invalid token" do
   get :edit, id: password_resets(:test).id,
       token: 'fail'
   assert_redirected_to forgot_password_path
 end

  test "update with valid id and token the password changes" do
    assert customers(:test).authenticate('password')
    post :update, id: password_resets(:test).id,
                  token: password_resets(:test).token,
                  password: 'secret'
    customers(:test).reload
    assert customers(:test).authenticate('secret'),
           "Expected password to be 'secret', but it is not..."
    assert_redirected_to log_in_path
  end
end
