class MenuItemsController < ApplicationController
  before_action :set_menu_item, only: [:show]

  # GET /menu_items
  # GET /menu_items.json
  def index
    session[:order_items] ||= {}

    sort = params[:sort] ? params[:sort] : 'name'
    order = params[:order] ? params[:order] : 'asc'

    case params[:category]
      when MenuItem.categories[:breakfast].to_s
        @breakfast_items = build_query(params[:name], params[:category], sort, order)
      when MenuItem.categories[:lunch].to_s
        @lunch_items = build_query(params[:name], params[:category], sort, order)
      when MenuItem.categories[:dinner].to_s
        @dinner_items = build_query(params[:name], params[:category], sort, order)
      when MenuItem.categories[:drink].to_s
        @drink_items = build_query(params[:name], params[:category], sort, order)
      else
        @breakfast_items = build_query(params[:name], MenuItem.categories[:breakfast], sort, order)
        @lunch_items = build_query(params[:name], MenuItem.categories[:lunch], sort, order)
        @dinner_items = build_query(params[:name], MenuItem.categories[:dinner], sort, order)
        @drink_items = build_query(params[:name], MenuItem.categories[:drink], sort, order)
    end
  end

  # GET /menu_items/1
  # GET /menu_items/1.json
  def show
    render :layout => false
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_menu_item
    @menu_item = MenuItem.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def menu_item_params
    params.fetch(:menu_item, {})
  end

  def build_query(name, category, sort, order)
    query = MenuItem.where(category: category).order(sort => order)
    if name
      query.where('lower(name) LIKE ?', "%#{name.downcase}%")
    else
      query
    end
  end
end
