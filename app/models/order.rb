class Order < ActiveRecord::Base
  has_many :order_items
  has_many :menu_items, through: :order_items

  attr_accessor :total, :discount_amount

  after_create :send_notification_to_user

  def total
    total = self.delivery + menu_items.inject(0) { |total, item| total + item.price }
    if discount
      total / 2
    else
      total
    end
  end

  def discount_amount
    if discount
      '50%'
    else
      '0'
    end
  end

  private
  def discount
    'coderschool' == coupon.downcase
  end

  def send_notification_to_user
    OrderMailer.order_created(self).deliver_now unless self.email.empty?
  end
end
