class BusinessProfilesController < ApplicationController
  def show
    @business = Business.find(params[:business_id])
    @business_profile = @business.business_profile
  end

  def new
    @business = Business.find(params[:business_id])
    @business_profile = @business.build_business_profile
    @product_categories = ProductCategory.all.sort { |a, b| a.name <=> b.name }
  end

  def create
    business = Business.find(params[:business_id])
    @business_profile = business.build_business_profile(params[:business_profile])


    if @business_profile.save
      if params["product_category"]
        params["product_category"].each do |category|
          @business_profile.product_categories << ProductCategory.find(params["product_category"][category[0]])
        end
      end

      redirect_to action: :show
    end
  end
  
  def edit
    business = Business.find(params[:business_id])
    @business_profile = business.business_profile
  end

  def updated
    business = Business.find(params[:business_id])
    @business_profile = business.business_profile

    if @business_profile.update_attributes(params[:business_profile])
      redirect_to action: show, business: business
    end
  end

  def destroy
    business = Business.find(params[:business_id])
    @business_profile = business.business_profile
    @business_profile.destroy
    redirect_to business_path(business)
  end
end
