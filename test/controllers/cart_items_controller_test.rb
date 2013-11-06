require 'test_helper'

class CartItemsControllerTest < ActionController::TestCase

  test "index should be success even if cart is empty" do
    session[:cart] = { products(:test).id.to_s => 1 }   #put stuff in the cart
    get :index #do a get to the index action of this controller
    assert_response :success
    assert_select 'td.product', :count => 0 #there shouldn't be any td's of class Product
    #assert_select 'td.product', products(:test).name   #assert_select looks for things in the html
                  #this test looks for a product class
  end

  test "create adds item to session" do
    post :create, product_id: 99           #being tested against controller and assert_equal 'Product 99 was ...'
    assert_redirected_to products_path
    assert_equal 'Product 99 was added to your cart.', flash[:notice]
  # { 99 => 1, 101 => 3 } (if there's a product id 99, I'll want 1 of them)
    assert_equal 1, session[:cart]['99']  #cart with a hash of product id to quantity
  end
end

