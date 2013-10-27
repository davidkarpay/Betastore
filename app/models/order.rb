class Order < ActiveRecord::Base
  def self.recent
    where("placed_at > ?", 7.days.ago)
  end

  def self.by(customer)
    where(customer_id: customer.id)
  end
#  belongs_to :customer
end
