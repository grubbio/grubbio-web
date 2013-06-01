class BusinessProfileFoodProduct < ActiveRecord::Base
  belongs_to :business_profile
  belongs_to :food_product
end
