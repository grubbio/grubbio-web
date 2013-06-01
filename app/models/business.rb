class Business < ActiveRecord::Base
  attr_accessible :name, :description

  has_one :business_profile
end
