# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# require 'csv'    

# csv_text = File.read('db/Export.csv')
# csv_text.encode('UTF-8')
# #puts "text: #{csv_text}"
# csv = CSV.parse(csv_text, :headers => true)
# csv.each do |row|
# 	if row.to_hash["state"] == "Colorado"
# 		puts row.to_hash
# 		unless Market.exists?(row.to_hash["fmid"])
# 		  Market.create!(row.to_hash)
# 		end
# 	end
# end

# %w(Produce Meat Dairy Poultry Processed Seafood Other).each do |category|
#   ProductCategory.create(:name => category)
# end

# VEGETABLES = [
# 	"Apple", "Banana", "Orange", "Strawberry", "Blueberry", "Cherry", "Radish", "Onion", "Potato", "Lettuce", "Spinach", "Asparagus",
# 	"Rhubarb", "Apricot", "Beet", "Cabbage", "Celery", "Cucumber", "Green Bean", "Chile Pepper", "Corn", "Eggplant", "Peach", "Plum",
# 	"Squash", "Tomato", "Watermelon", "Grape", "Raspberry", "Carrot", "Tomatillo", "Blackberry", "Mushroom"
# ]

# VEGETABLES.each do |food|
# 	new_food = FoodProduct.create({ name: food, product_category_id: 1 })
# 	puts new_food.name
# end

# MEATS = [
# 	"Pork", "Beef", "Sausage", "Bacon", "Lamb"
# ]

# MEATS.each do |meat|
# 	new_food = FoodProduct.create({ name: meat, product_category_id: 2 })
# 	puts new_food.name
# end

# POULTRYS = [
# 	"Chicken", "Turkey"
# ]

# POULTRYS.each do |poultry|
# 	new_food = FoodProduct.create({ name: poultry, product_category_id: 4 })
# 	puts new_food.name
# end

# DAIRYS = [
# 	"Milk", "Cheese", "Butter", "Eggs"
# ]

# DAIRYS.each do |dairy|
# 	new_food = FoodProduct.create({ name: dairy, product_category_id: 3 })
# 	puts new_food.name
# end

# FoodProduct.create({ name: 'Honey', product_category_id: 7 })

# market_ids = Market.all.map {|market| market.id}
# food_ids = FoodProduct.all.map {|food| food.id}
# market_ids.each do |id|
# 	(1..12).each do
# 		Market.find(id).food_products << FoodProduct.find(food_ids.sample)
# 	end
# end

# b = Business.create(:name => "Jeff's Tilapia and Tomatoes", :description => "The best aquaponic food in Colorado")
# b.create_business_profile(:address1 => "1500 Wynkoop St.", :city => "Denver", :state => "CO", :zip_code => "80202")

# (1..5).each do |i|
# 	b.business_profile.food_products << FoodProduct.find(i)
# end

# broken_links = []

# markets = Market.all

# markets.each do |market|
# 	begin
# 		if market.website
# 			response = HTTParty.get(market.website)
# 			if response.code.to_s != '200'
# 				data = {
# 					id: market.fmid,
# 					url: market.website
# 				}
# 				broken_links << data
# 				puts "#{market.fmid} - BROKEN"
# 			else
# 				puts "#{market.fmid}"
# 			end
# 		end
# 	rescue
# 		puts "rescued?"
# 	end
# end

# puts broken_links

USERS = [	{user_email: "consumer@grubb.io", password: "password", location: "Denver, CO"},
					{user_email: "producer@grubb.io", password: "password", location: "Denver, CO"},
					{user_email: "market@grubb.io", password: "password", location: "Denver, CO"},
					{user_email: "admin@grubb.io", password: "password", location: "denver, CO"}
				]

USERS.each do |user|
	user = User.new(email: user[:user_email], password: user[:password], raw_location: user[:location])
	case user.email
	when "consumer@grubb.io"
		user.add_role("consumer")
	when "producer@grubb.io"
		user.add_role("producer")
	when "market@grubb.io"
		user.add_role("market_manager")
	when "admin@grubb.io"
		user.add_role("admin")
	end
	user.save
end









