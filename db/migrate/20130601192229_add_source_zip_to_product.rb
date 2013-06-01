class AddSourceZipToProduct < ActiveRecord::Migration
  def change
    add_column(:food_products, :zip_code, :string)
  end
end
