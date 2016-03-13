class Order < ActiveRecord::Base
  has_many :order_items
  has_many :menu_items, through: :order_items

  attr_accessor :total

  def total
    food_cost = menu_items.inject(0) { |total, item| total + item.price }
    food_cost + self.delivery
  end
end
