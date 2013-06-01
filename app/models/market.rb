class Market < ActiveRecord::Base
  attr_accessible :bakedgoods, :cheese, :city, :county, :crafts, :credit, :eggs, :flowers, :fmid, :herbs, :honey, :jams,
  								:location, :maple, :market_name, :meat, :nursery, :nuts, :plants, :poultry, :prepared, :schedule, :seafood,
  								:sfmnp, :snap, :soap, :state, :street, :trees, :update_time, :vegetables, :website, :wic, :wic_cash, :wine, :x, :y, :zip

  has_many :market_food_products
  has_many :food_products, :through => :market_food_products

  accepts_nested_attributes_for :food_products

  geocoded_by :full_street_address  # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates

	reverse_geocoded_by :y, :x
	after_validation :reverse_geocode  # auto-fetch address

	def full_street_address
		"#{street}, #{city}, #{state}"
	end

	def self.get_markets_near_me(lat, long, distance)
		Market.near([lat, long], distance)
	end 

end
