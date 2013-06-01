class BusinessesController < ApplicationController
  respond_to :html, :json

  def index
    @businesses = Business.all
    respond_with(@businesses)
  end

  def show
    @business = Business.find(params[:id])
    respond_with(@business)
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(params[:business])

    if @business.save
      redirect_to action: :index
    end
  end

  def edit
    @business = Business.find(params[:id])
  end

  def update
    @business = Business.find(params[:id])
    if @business.update_attributes(params[:business])
      redirect_to action: :index
    end
  end

  def destroy
    @business = Business.find(params[:id])
    @business.destroy
    redirect_to action: :index
  end
end
