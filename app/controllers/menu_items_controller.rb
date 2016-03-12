class MenuItemsController < ApplicationController
  before_action :set_menu_item, only: [:show, :edit, :update, :destroy]

  # GET /menu_items
  # GET /menu_items.json
  def index
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

  # GET /menu_items/new
  def new
    @menu_item = MenuItem.new
  end

  # GET /menu_items/1/edit
  def edit
  end

  # POST /menu_items
  # POST /menu_items.json
  def create
    @menu_item = MenuItem.new(menu_item_params)

    respond_to do |format|
      if @menu_item.save
        format.html { redirect_to @menu_item, notice: 'Menu item was successfully created.' }
        format.json { render :show, status: :created, location: @menu_item }
      else
        format.html { render :new }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menu_items/1
  # PATCH/PUT /menu_items/1.json
  def update
    respond_to do |format|
      if @menu_item.update(menu_item_params)
        format.html { redirect_to @menu_item, notice: 'Menu item was successfully updated.' }
        format.json { render :show, status: :ok, location: @menu_item }
      else
        format.html { render :edit }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_items/1
  # DELETE /menu_items/1.json
  def destroy
    @menu_item.destroy
    respond_to do |format|
      format.html { redirect_to menu_items_url, notice: 'Menu item was successfully destroyed.' }
      format.json { head :no_content }
    end
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
