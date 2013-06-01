module Location

	FORMAT = "json"
	ESRI_BASE_URL = "http://geocode.arcgis.com/"
	ESRI_ADDRESS = "arcgis/rest/services/World/GeocodeServer/find"
	ESRI_COORDINATES = "/ArcGIS/rest/services/Locators/ESRI_Geocode_USA/GeocodeServer/reverseGeocode"

	# lng(x),lat(y) (esri wants coordinates in that order to be sent)
	def get_address(coordinates)

		# OFFLINE UNTIL WE GET AN ESRI TOKEN FOR REVERSE GEOCODING

		# url = "#{ESRI_BASE_URL}#{ESRI_COORDINATES}?location=#{coordinates[0]},#{coordinates[1]}&f=#{FORMAT}"
		# puts url
		# response = HTTParty.get(url)
		# body = JSON.parse response.body

		# binding.pry

		# address = "#{body['address']['Address']}, #{body['address']['City']}"
		# puts address
		# return address
	end

	def get_coordinates(address)
		url = "#{ESRI_BASE_URL}#{ESRI_ADDRESS}?text=#{Rack::Utils.escape address}&f=#{FORMAT}"
		puts url
		response = HTTParty.get(url)
		body = JSON.parse response.body
		data = body['locations'].first['feature']['geometry']
		coordinates = []
		coordinates << data['x']
		coordinates << data['y']

		return coordinates
	end

end