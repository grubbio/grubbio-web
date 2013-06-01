class CreateFoodProducts < ActiveRecord::Migration
  def change
    create_table :food_products do |t|
      t.integer :product_category_id
      t.string :name
      t.string :description
      t.timestamps
    end
  end
end
