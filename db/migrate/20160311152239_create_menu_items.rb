class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :category
      t.string :image_url

      t.timestamps null: false
    end
  end
end
