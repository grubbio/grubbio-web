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

%w(Produce Meat Dairy Poultry Processed Seafood Other).each do |category|
  ProductCategory.create(:name => category)
end

VEGETABLES = [
	"Apple", "Banana", "Orange", "Strawberry", "Blueberry", "Cherry", "Radish", "Onion", "Potato", "Lettuce", "Spinach", "Asparagus",
	"Rhubarb", "Apricot", "Beet", "Cabbage", "Celery", "Cucumber", "Green Bean", "Chile Pepper", "Corn", "Eggplant", "Peach", "Plum",
	"Squash", "Tomato", "Watermelon", "Grape", "Raspberry", "Carrot", "Tomatillo", "Blackberry", "Mushroom"
]

VEGETABLES.each do |food|
	new_food = FoodProduct.create({ name: food, product_category_id: 1 })
	puts new_food.name
end

MEATS = [
	"Pork", "Beef", "Sausage", "Bacon", "Lamb"
]

MEATS.each do |meat|
	new_food = FoodProduct.create({ name: meat, product_category_id: 2 })
	puts new_food.name
end

POULTRYS = [
	"Chicken", "Turkey"
]

POULTRYS.each do |poultry|
	new_food = FoodProduct.create({ name: poultry, product_category_id: 4 })
	puts new_food.name
end

DAIRYS = [
	"Milk", "Cheese", "Butter", "Eggs"
]

DAIRYS.each do |dairy|
	new_food = FoodProduct.create({ name: dairy, product_category_id: 3 })
	puts new_food.name
end

FoodProduct.create({ name: 'Honey', product_category_id: 7 })