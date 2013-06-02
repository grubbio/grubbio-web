class Season < ActiveRecord::Base
  attr_accessible :food_product_id, :month, :state

  belongs_to :food_product
end
