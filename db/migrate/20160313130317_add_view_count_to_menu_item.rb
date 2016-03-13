class AddViewCountToMenuItem < ActiveRecord::Migration
  def change
    add_column :menu_items, :view_count, :integer, default: 0
  end
end
