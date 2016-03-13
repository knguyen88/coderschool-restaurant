class OrdersController < ApplicationController
  before_action :set_order, only: [:show]

  # GET /orders/1
  # GET /orders/1.json
  def show
    render layout: false
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.delivery = 20000
    menu_items = MenuItem.where(:id => params[:order].split(','))
    @order.menu_items << menu_items
    @order.save

    session.delete(:order_items)
    redirect_to order_path(@order.id)
  end

  def add_item
    @new_item = to_new_item_hash(MenuItem.where(:id => params[:id]).pluck(:id, :name, :price).first)

    session['order_items'] ||= {}
    if session['order_items'].key?(@new_item['id'])
      session['order_items'][@new_item['id']]['quantity'] += 1
    else
      session['order_items'][@new_item['id']] = @new_item
    end
    render '/orders/_add_item', layout: false
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.permit(:name, :phone, :email, :address, :coupon)
  end

  def to_new_item_hash(attrs)
    {'id' => attrs[0].to_s, 'name' => attrs[1], 'price' => attrs[2], 'quantity' => 1}
  end
end
