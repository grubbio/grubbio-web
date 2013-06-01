class CreateMarketFoodProducts < ActiveRecord::Migration
  def change
    create_table :market_food_products do |t|
      t.integer :market_id
      t.integer :food_product_id

      t.timestamps
    end
  end
end
