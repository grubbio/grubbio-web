class MarketFoodProduct < ActiveRecord::Base
  attr_accessible :food_product_id, :market_id

  belongs_to :market
  belongs_to :food_product
end
