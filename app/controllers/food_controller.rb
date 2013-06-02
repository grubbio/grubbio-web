class FoodController < ApplicationController

	def index
		@foods = FoodProduct.paginate(page: params[:page], per_page: 30)
	end

	def show
		@food = FoodProduct.find(params[:id])
    ids = BusinessProfileFoodProduct.find_all_by_food_product_id(params[:id])
    @businesses = Business.find(BusinessProfile.find(ids).map(&:id))
	end

end