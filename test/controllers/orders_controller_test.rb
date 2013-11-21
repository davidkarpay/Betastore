require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  test "display checkout form with with a button that submits to the create action" do
    assert_select "button"
    assert_select
    puts @response.body
    get :new
    assert_response :success
  end

end
