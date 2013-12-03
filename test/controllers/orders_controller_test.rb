require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  test "display checkout form with with a button that submits to the create action" do
    assert_select "button"
    assert_select
    puts @response.body
    get :new
    assert_response :success
  end

  test "redirects to home page with notice" do
    post :create, order: { credit_card_attributes: {}, line_item_attributes: [] }
    assert_redirected_to root_path
    assert_equal "Your order has been placed", flash[:notice]
  end

end
