class OrderMailer < ApplicationMailer
  def order_created(order)
    @order = order
    mail(to: order.email, subject: 'Your order has been creates successfully.')
  end
end
