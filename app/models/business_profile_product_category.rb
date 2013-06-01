class BusinessProfileProductCategory < ActiveRecord::Base
  belongs_to :business_profile
  belongs_to :product_category
end
