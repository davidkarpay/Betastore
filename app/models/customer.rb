class Customer < ActiveRecord::Base
  has_many :orders
  has_many :line_items, :through => :orders
  has_many :products, :through => :line_items
  has_many :password_resets
  has_many :tracking_numbers, :through => :orders
  validates_presence_of :name, :email, :password, :password_confirmation

  has_secure_password
end
