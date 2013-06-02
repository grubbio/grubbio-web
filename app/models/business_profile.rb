class BusinessProfile < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :state, :zip_code

  belongs_to :business
  has_many :business_profile_food_products
  has_many :food_products, :through => :business_profile_food_products

  has_many :business_profile_product_categories
  has_many :product_categories, :through => :business_profile_product_categories

  def formatted_address
    address1 + "<br/>" + 
    address2 + "<br/>" +
    "#{city}, #{state} #{zip_code}"
  end
end
