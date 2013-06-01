class CreateBusinessProfileFoodProducts < ActiveRecord::Migration
  def change
    create_table :business_profile_food_products do |t|
      t.integer :business_profile_id
      t.integer :food_product_id
      t.timestamps
    end
  end
end
