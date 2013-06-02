class BusinessDashboardsController < ApplicationController
  before_filter :get_business

  def show
    redirect_to action: :animal_husbandry
  end

  def animal_husbandry
  end

  def aquaculture
  end

  def farmers_market
  end

  def plant_husbandry
  end

  def plant_nursery
  end

  def primary_food_sales
  end

  def urban_garden
  end

  private

  def get_business
    @business = Business.find(params[:business_id])
  end
end
