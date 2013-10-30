module ApplicationHelper
  def product_title(product)
    "#{product_title} - ##{product.id}"
  end

  def copyright_year
    Time.current.year
  end
end
