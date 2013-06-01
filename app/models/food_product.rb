class FoodProduct < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :market_food_products
  has_many :markets, :through => :market_food_product

  has_many :seasons

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
end
