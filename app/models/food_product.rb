class FoodProduct < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :market_food_products
  has_many :markets, :through => :market_food_product
end
