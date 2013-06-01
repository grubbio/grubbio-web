class MarketsController < ApplicationController

  respond_to :json, :html

  def index
    distance = params[:distance].present? ? params[:distance] : 10
    if params[:zip].present?
      coordinates = Geocoder.coordinates(params[:zip])
      @markets = Market.get_markets_near_me(coordinates[0], coordinates[1], distance)
    elsif params[:lat].present? && params[:long].present?
      @markets = Market.get_markets_near_me(params[:lat], params[:long], distance)
    else
      @markets = Market.limit(40).all
    end
    respond_with @markets
  end

  def show
    @market = Market.find(params[:id])

    respond_with @market
  end

  def new
    @market = Market.new
  end

  def edit
    @market = Market.find(params[:id])
  end

  def create
    @market = Market.new(params[:market])

    respond_to do |format|
      if @market.save
        format.html { redirect_to @market, notice: 'Market was successfully created.' }
        format.json { render json: @market, status: :created, location: @market }
      else
        format.html { render action: "new" }
        format.json { render json: @market.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @market = Market.find(params[:id])

    respond_to do |format|
      if @market.update_attributes(params[:market])
        format.html { redirect_to @market, notice: 'Market was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @market.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @market = Market.find(params[:id])
    @market.destroy

    respond_to do |format|
      format.html { redirect_to markets_url }
      format.json { head :no_content }
    end
  end
end
