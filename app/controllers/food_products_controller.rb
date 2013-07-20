class FoodProductsController < ApplicationController
  def show
    @food = FoodProduct.find(params[:id])
    ids = BusinessProfileFoodProduct.find_all_by_food_product_id(params[:id])
    @businesses = Business.find(BusinessProfile.find(ids).map(&:id))
  end
end