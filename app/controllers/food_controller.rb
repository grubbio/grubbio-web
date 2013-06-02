class FoodController < ApplicationController

	def index
		@foods = FoodProduct.paginate(page: params[:page], per_page: 30)
	end

	def show
		@food = FoodProduct.find(params[:id])
	end

end