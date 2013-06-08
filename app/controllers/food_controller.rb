class FoodController < ApplicationController

	def index
		@foods = FoodProduct.all
    @foods = Kaminari.paginate_array(@foods).page(params[:page])
	end

	def show
		@food = FoodProduct.find(params[:id])
    ids = BusinessProfileFoodProduct.find_all_by_food_product_id(params[:id])
    @businesses = Business.find(BusinessProfile.find(ids).map(&:id))
	end

end