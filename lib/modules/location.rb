module Location

	FORMAT = "json"
	ESRI_BASE_URL = "http://geocode.arcgis.com/"
	ESRI_ADDRESS = "arcgis/rest/services/World/GeocodeServer/find"
	ESRI_COORDINATES = "arcgis/rest/services/World/GeocodeServer/reverseGeocode"

	# lng(x),lat(y) (esri wants coordinates in that order to be sent)
	def get_address(coordinates)
		url = "#{ESRI_BASE_URL}#{ESRI_COORDINATES}?location=#{coordinates[0]},#{coordinates[1]}&f=#{FORMAT}"
		puts url
		response = HTTParty.get(url)
		body = JSON.parse response.body

		data = {
			street: body['address']['Address'],
			city: body['address']['City'],
			state: body['address']['Region'],
			zip: body['address']['Postal']
		}
		
		return data
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