class MarketsController < ApplicationController

  autocomplete :market, :market_name
  
  respond_to :json, :js, :html

  #before_filter :check_for_current_user

  def index
    search = {}
    search[:distance] = params[:distance].present? ? params[:distance] : 10
    search[:term] = params[:term].present? ? params[:term] : nil
    search[:zip] = params[:zip].present? ? params[:zip] : nil
    search[:food] = params[:food].present? ? params[:food] : nil
    search[:lat] = params[:lat].present? ? params[:lat] : nil
    search[:long] = params[:long].present? ? params[:long] : nil

    @markets = Market.search(search)

    @total_count = @markets.length
    if @markets.first.is_a?(ActiveRecord::Relation)
      markets_array = []
      @markets.first.each do |m|
        # binding.pry
        markets_array << m
      end
      @total_count = markets_array.length
      @markets = markets_array
    end
    @markets.flatten
    @markets = Kaminari.paginate_array(@markets).page(params[:page])
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
