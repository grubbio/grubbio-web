class User < ActiveRecord::Base
	include Location

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :lat, :lng, :raw_address

 	validates :email, presence: true

 	# send in coordinates array as lng,lat
 	def geolocate(input)
 		if input.kind_of?(Array)
 			self.raw_address = self.get_address(input)
 		elsif input.kind_of?(String)
 			coords = self.get_coordinates(input)
 			self.lng = coords[0]
 			self.lat = coords[1]
 		end
 		self.save
 	end

end
