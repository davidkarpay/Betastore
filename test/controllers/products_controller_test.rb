require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
#you'll need to make a controller, a view, and a route in order
  #for any controller tests to pass at all
  #BUT, they will give you an error, which is another reason why
  #it's better to use tests than just rendering every single
  #(*&% condition of a page.

  test "index" do
    get :index
    assert_response :success
    puts @response.body
    assert_select "h2 a", text: 'Example', #test to see if a product we want is actually rendered
                          count: 1
  end

  test "show" do
    get :show, id: products(:test).id
    assert_response :success

    assert_select "h2", text: 'Example' , count: 1
    assert_select "h2", text: 'Other' , count: 0
  end

end

