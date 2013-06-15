class User < ActiveRecord::Base
  rolify
	
  include Location

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :lat, :lng, :raw_location, :address_state, :address_city, 
                  :address_zip, :address_street, :registration_roles

  attr_accessor   :registration_roles
  
 	validates :email, presence: true

 	before_create :run_geolocation, :set_roles

 	def run_geolocation 
 		self.geolocate(self.raw_location)
	end

 	# send in coordinates array as lng,lat
 	def geolocate(input)
 		if input.kind_of?(Array)
 			address_data = self.get_address(input)
 			self.address_street = address_data[:street]
 			self.address_city = address_data[:city]
 			self.address_state = address_data[:state]
 			self.address_zip = address_data[:zip].to_i
 		elsif input.kind_of?(String)
 			coords = self.get_coordinates(input)
 			self.lng = coords[0]
 			self.lat = coords[1]
 		end
 	end

 	def state_located?
 		if self.address_state.blank?
 			get_state
 		end
 		true
 	end

 	def get_state
 		if self.address_state.blank?
 			address_data = self.get_address([self.lng,self.lat])
 			self.address_street = address_data[:street]
 			self.address_city = address_data[:city]
 			self.address_state = address_data[:state]
 			self.address_zip = address_data[:zip].to_i
 			self.save
 		end
 		self.address_state
 	end

  def set_roles
    registration_roles.each do |role|
      if role.present? then add_role role.to_sym end
    end
  end

end
