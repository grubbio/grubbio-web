class BusinessProfile < ActiveRecord::Base
  attr_accessible :producer_types, :consumer_types

  belongs_to :business
  has_many :food_products, :through => :business_profile_food_product
  has_many :product_categories, :through => :business_profile_product_category
end
