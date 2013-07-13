class MarketsController < ApplicationController

  autocomplete :market, :market_name, :full => true
  
  respond_to :json, :js, :html

  #before_filter :check_for_current_user

  def index
    @markets = Market.custom_search(params)
    if params[:market_search].present?
      @search = { query: params[:market_search]["query"],
                distance: params[:market_search]["distance"],
                location: params[:market_search]["location"]
      }
    else
      @search = nil
    end
    @total_count = @markets.length
    @markets = Kaminari.paginate_array(@markets.present? ? @markets : []).page(params[:page])
    respond_with @markets
  end

  def show
    if params[:term].present?
      @markets = Market.all(:conditions => ['market_name LIKE ?', "%#{params[:term].downcase}%"])
    end
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

  def check_for_current_user
    if current_user.blank?
      redirect_to root_path, :alert => "Please sign in to see your local markets"
    end
  end
end
