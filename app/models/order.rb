class Order < ActiveRecord::Base

  belongs_to :customer
  has_many :line_items
  has_many :products, :through => :line_items

  def self.recent                             #these are methods to be used within the rails c
    where("placed_at > ?", 7.days.ago)  #where("...) is a sql query/relation.
  end

  def self.by(customer)
    where(customer_id: customer.id)
  end

end
