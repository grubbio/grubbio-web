class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :food_product_id
      t.string :state
      t.date :month

      t.timestamps
    end
  end
end
