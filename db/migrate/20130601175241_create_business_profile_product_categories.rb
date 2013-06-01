class CreateBusinessProfileProductCategories < ActiveRecord::Migration
  def change
    create_table :business_profile_product_categories do |t|
      t.integer :business_profile_id
      t.integer :product_category_id
      t.timestamps
    end
  end
end
