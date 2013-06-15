class Market < ActiveRecord::Base

  resourcify

  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  attr_accessible :bakedgoods, :cheese, :city, :county, :crafts, :credit, :eggs, :flowers, :fmid, :herbs, :honey, :jams,
  								:location, :maple, :market_name, :meat, :nursery, :nuts, :plants, :poultry, :prepared, :schedule, :seafood,
  								:sfmnp, :snap, :soap, :state, :street, :trees, :update_time, :vegetables, :website, :wic, :wic_cash, :wine,
  								:x, :y, :zip, :food_products

  has_many :market_food_products
  has_many :food_products, :through => :market_food_products

  accepts_nested_attributes_for :food_products

  geocoded_by :full_street_address  # can also be an IP address
	after_validation :geocode          # auto-fetch coordinates

	reverse_geocoded_by :y, :x, :address => :street
	after_validation :reverse_geocode  # auto-fetch address

	def self.custom_search(query)
		distance = query[:distance]
		zip_markets = []
		if query[:zip].present?
			coordinates = Geocoder.coordinates(query[:zip])
  	  zip_markets = Market.get_markets_near_me(coordinates[0], coordinates[1], distance)
  	end
  	food_markets = []
  	if query[:food].present?
  		food_markets = Market.with_food(query[:food])
		end
		term_markets = []
  	if query[:term].present?
  		term_markets = Market.all(:conditions => ['market_name LIKE ?', "%#{query[:term].downcase}%"])
  	end
  	latlong_markets = []
  	if query[:lat].present? && query[:long].present?
  		latlong_markets = Market.get_markets_near_me(query[:lat], query[:long], distance)
  	end

  	if zip_markets.empty? && food_markets.empty? && term_markets.empty? && latlong_markets.empty?
  	  return Market.all
  	else
  		populated_arrays = []
  		market_arrays = [] << zip_markets << food_markets << term_markets << latlong_markets
  		market_arrays.each do |ma|
  			if ma.any?
  				populated_arrays << ma
  			end
  		end
  		markets = populated_arrays.first
  		(1..populated_arrays.length).each_with_index do |a, i|
  			markets = markets | populated_arrays[i]
  		end
  		return markets.uniq{|m| m.fmid}
  	end
  end

	def full_street_address
		"#{street}, #{city}, #{state}"
	end

	def self.get_markets_near_me(lat, long, distance)
		Market.near([lat, long], distance)
	end 

	def self.with_food(food)
		markets= []
		Market.all.each do |m|
			m.food_products.each do |f|
				if f.name == food
					markets << m
				end
			end
		end
		return markets
	end
end
