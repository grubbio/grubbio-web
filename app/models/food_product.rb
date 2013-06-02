class FoodProduct < ActiveRecord::Base
  attr_accessible :name, :description, :product_category_id

  has_many :market_food_products
  has_many :markets, :through => :market_food_product

  has_many :seasons
  belongs_to :product_category

  def season_status(state)
  	if self.seasons.blank?
  		return 'no seasonal data available'
  	else
  		if self.locations.include? state
  			season = self.seasons.where(month: (Date.today.beginning_of_month)..(Date.today.end_of_month)).last
        if season.present?
  				return 'in season'
  			else
  				return 'out of season'
  			end
  		else
  			return 'no seasonal data for state'
  		end
  	end
  end

  def locations
    seasons.pluck("DISTINCT state")
  end

  def get_recipes
    yummly_app_id = "d4b9e8b5"
    yummly_api_key = "5ce57d748fa247564c5807430a398fd6"
    yummly_base = "http://api.yummly.com/v1/api/metadata/ingredients"
    app_param = "_app_id=#{yummly_app_id}"
    key_param = "_app_key=#{yummly_api_key}"

    query = "allowedIngredient[]=#{Rack::Utils.escape self.name}"
    pictures = "requirePictures=true"

    url = "#{yummly_base}?#{app_param}&#{key_param}&#{query}"

    response = HTTParty.get(url)

    puts response.body

    return response.body
  end
end
