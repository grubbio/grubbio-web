class UsersController < ApplicationController

  def new
    @registration_roles = [["Consumer", "consumer"], ["Producer", "producer"], ["Market manager", "market_manager"]]
  end

	def show
		
	end

end