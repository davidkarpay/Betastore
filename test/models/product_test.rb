require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "name" do
    product = products(:test)
    assert_equal "Example", products(:test).name
   end
end
