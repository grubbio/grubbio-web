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

# %w(Produce Meat Dairy Poultry Processed Seafood).each do |category|
#   ProductCategory.create(:name => category)

# FOODS = [
# 	"Apple", "Banana", "Orange", "Strawberry", "Blueberry", "Cherry", "Radish", "Onion", "Potato", "Lettuce", "Spinach", "Asparagus",
# 	"Rhubarb", "Apricot", "Beet", "Cabbage", "Celery", "Cucumber", "Green Bean", "Chile Pepper", "Corn", "Eggplant", "Peach", "Plum",
# 	"Squash", "Tomato", "Watermelon", "Grape", "Raspberry"
# ]

# FOODS.each do |food|
# 	new_food = FoodProduct.create({ name: food })
# 	puts new_food.name
# end