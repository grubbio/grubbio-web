class FoodController < ApplicationController

	def index
		@foods = FoodProduct.all
	end

	def show
		@food = FoodProduct.find(params[:id])
	end

end