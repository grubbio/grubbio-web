class Market < ActiveRecord::Base

  resourcify

  attr_accessible :bakedgoods, :cheese, :city, :county, :crafts, :credit, :eggs, :flowers, :fmid, :herbs, :honey, :jams,
                  :location, :maple, :market_name, :meat, :nursery, :nuts, :plants, :poultry, :prepared, :schedule, :seafood,
                  :sfmnp, :snap, :soap, :state, :street, :trees, :update_time, :vegetables, :website, :wic, :wic_cash, :wine,
                  :x, :y, :zip, :food_products

  #Denver = 39.7392° N, 104.9842° W
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

  after_save do
    update_index
  end


  settings :number_of_shards => 1,
           :number_of_replicas => 1,
           :analysis => {
             :filter => {
               :market_ngram  => {
                 "type"     => "EdgeNGram",
                 "max_gram" => 5,
                 "min_gram" => 3 }
             },
             :analyzer => {
               :market_analyzer => {
                  "tokenizer"    => "lowercase",
                  "filter"       => ["stop", "market_ngram"],
                  "type"         => "custom" }
             }
    } do
  
    mapping do
      indexes :market_name, :type => 'string', :store => 'yes', :boost => 100, :analyzer => :market_analyzer
      indexes :location, type: 'string', boost: 10, analyzer: 'market_analyzer'
      indexes :city, type: 'string', boost: 3, analyzer: 'market_analyzer'
      indexes :state, type: 'string', boost: 3, analyzer: 'market_analyzer'
      indexes :street, type: 'string', boost: 3, analyzer: 'market_analyzer'
      indexes :zip, type: 'string', boost: 3, analyzer: 'market_analyzer'
      indexes :food_products do
        indexes :name, :store => 'yes', :type => 'string', :boost => 100, :analyzer => :market_analyzer
        indexes :description, type: 'string', analyzer: 'market_analyzer'
      end
    end
  end

  def to_indexed_json
    to_json( include: [:food_products] )
  end

  def self.search(query)
    tire.search do
      query { string "#{query}", :default_operator => :AND, :fields => ['market_name', 'location', 'city', 'state', 'street', 'zip', 'name', 'description'] }
      # highlight :attachment
      # page = (options[:page] || 1).to_i
      # search_size = options[:per_page] || DEFAULT_PAGE_SIZE
      # from (page -1) * search_size
      # size search_size
      sort { by :_score, :desc }
    end
  end

	def self.custom_search(params)
    if params[:lat].present? && params[:long].present?
      return @markets = self.lat_long_search({lat: params[:lat], long: params[:long]})
    end
    if params[:market_search].present?
  		distance = params[:market_search][:distance].present? ? params[:market_search][:distance] : 10
      location = params[:market_search][:location]
      query = params[:market_search][:query]
      coordinates = Geocoder.coordinates(location)

      #FIXME: optimize this array creation- don't reinstantiate the Markets from the geocoder search
      location_search = location.present? ? Market.get_markets_near_me(coordinates[0], coordinates[1], distance) : Market.all
      query_search = query.present? ? Market.search(query) : Market.all
      loc_ids = location_search.flat_map {|market| market.id}
      query_ids = query_search.flat_map {|market| market.id.to_i}
      @markets  = (loc_ids & query_ids).map {|id| Market.find(id)}

      return @markets
    else
      return Market.all
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
