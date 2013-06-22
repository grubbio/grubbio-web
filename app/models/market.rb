class Market < ActiveRecord::Base

  resourcify

  attr_accessible :bakedgoods, :cheese, :city, :county, :crafts, :credit, :eggs, :flowers, :fmid, :herbs, :honey, :jams,
                  :location, :maple, :market_name, :meat, :nursery, :nuts, :plants, :poultry, :prepared, :schedule, :seafood,
                  :sfmnp, :snap, :soap, :state, :street, :trees, :update_time, :vegetables, :website, :wic, :wic_cash, :wine,
                  :x, :y, :zip, :food_products

  geocoded_by :full_street_address  # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  reverse_geocoded_by :y, :x, :address => :street
  after_validation :reverse_geocode  # auto-fetch address

  has_many :market_food_products
  has_many :food_products, :through => :market_food_products

  accepts_nested_attributes_for :food_products

  after_touch() { tire.update_index }
  self.include_root_in_json = false

  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  mapping do
    indexes :market_name, type: 'string', boost: 10, analyzer: 'snowball'
    indexes :location, type: 'string', boost: 10, analyzer: 'snowball'
    indexes :schedule, type: 'string', boost: 5, analyzer: 'snowball'
    indexes :city, type: 'string', boost: 3, analyzer: 'snowball'
    indexes :state, type: 'string', boost: 3, analyzer: 'snowball'
    indexes :street, type: 'string', boost: 3, analyzer: 'snowball'
    indexes :zip, type: 'string', boost: 3, analyzer: 'snowball'
    indexes :created_at, type: 'date'
 
    indexes :food_products  do
      indexes :name, type: :string, analyzer: 'snowball'
      indexes :description, type: :string, analyzer: 'snowball'
    end
  end

  def to_indexed_json
    to_json( include: [:food_products] )
  end

	def self.custom_search(params)
    if params[:lat].present? && params[:long].present?
      return @markets = self.lat_long_search({lat: params[:lat], long: params[:long]})
    end
    if params[:search].present?
  		distance = 10#params[:search][:distance]
      location = params[:search][:location]
      query = params[:search][:query]
      coordinates = Geocoder.coordinates(location)
      location_search = location.present? ? Market.get_markets_near_me(coordinates[0], coordinates[1], distance) : Market.all
      query_search = query.present? ? Market.search(query) : Market.all
      loc_ids = location_search.flat_map {|market| market.id}
      query_ids = query_search.flat_map {|market| market.id.to_i}
      @markets  = (loc_ids & query_ids).map {|id| Market.find(id)}


      return @markets
    end
		# if location.present? && query.present?
  #     coordinates = Geocoder.coordinates(location)
  #     return Market.get_markets_near_me(coordinates[0], coordinates[1], distance).search(query)
  #   elsif location.present?
  #     coordinates = Geocoder.coordinates(location)
  #     return Market.get_markets_near_me(coordinates[0], coordinates[1], distance)
  #   elsif query.present?
  #     return Market.search(query)
  #   else
  #     return Market.all
  #   end

  	# latlong_markets = []
  	# if query[:lat].present? && query[:long].present?
  	# 	latlong_markets = Market.get_markets_near_me(query[:lat], query[:long], distance)
  	# end

  	# if zip_markets.empty? && food_markets.empty? && term_markets.empty? && latlong_markets.empty?
  	#   return Market.all
  	# else
  	# 	populated_arrays = []
  	# 	market_arrays = [] << zip_markets << food_markets << term_markets << latlong_markets
  	# 	market_arrays.each do |ma|
  	# 		if ma.any?
  	# 			populated_arrays << ma
  	# 		end
  	# 	end
  	# 	markets = populated_arrays.first
  	# 	(1..populated_arrays.length).each_with_index do |a, i|
  	# 		markets = markets | populated_arrays[i]
  	# 	end
  	# 	return markets.uniq{|m| m.fmid}
  	# end
  end

  def self.lat_long_search(coordinates, distance=5)
    Market.get_markets_near_me(coordinates[:lat], coordinates[:long], distance)
  end

	def full_street_address
		"#{street}, #{city}, #{state}"
	end

	def self.get_markets_near_me(lat, long, distance)
		Market.near([lat, long], distance)
	end 

  def self.filter_by_distance(markets, lat, long, distance)
    t1 = Time.now
    markets & Market.near([lat, long], distance)
    t2 = Time.now
    Market.near([lat, long], distance) & markets
    t3 = Time.now
    puts "#{(t2-t1)*1000.00}"
    puts "#{(t3-t2)*1000.00}"
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
