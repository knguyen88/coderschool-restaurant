class MenuItem < ActiveRecord::Base
  enum category: [:breakfast, :lunch, :dinner, :drink]
  has_many :order_items
  has_many :orders, through: :order_items
end
