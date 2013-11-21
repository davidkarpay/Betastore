class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :credit_card
  has_many :line_items
  has_many :products, :through => :line_items
  accepts_nested_attributes_for :line_items
  has_one :tracking_number

  def self.recent                             #these are methods to be used within the rails c
    where("placed_at > ?", 7.days.ago)  #where("...) is a sql query/relation.
  end

  def self.by(customer)
    where(customer_id: customer.id)
  end

  def total_price
    line_items.inject(0) do |sum, li|
      li.total_price + sum
    end
  end
end
