class CreateBusinessProfiles < ActiveRecord::Migration
  def change
    create_table :business_profiles do |t|
      t.integer :business_id
      t.string :producer_types
      t.string :customer_types
      t.timestamps
    end
  end
end
