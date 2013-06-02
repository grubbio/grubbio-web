class BusinessProfileProductCategory < ActiveRecord::Base
  attr_accessible :business_profile_id, :product_category_id
  
  belongs_to :business_profile
  belongs_to :product_category
end
