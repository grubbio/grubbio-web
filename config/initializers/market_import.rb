# require 'csv'    

# csv_text = File.read('db/Export.csv')
# csv_text.encode('UTF-8')
# #puts "text: #{csv_text}"
# csv = CSV.parse(csv_text, :headers => true)
# csv.each do |row|
# 	puts "row.to_hash: #{row.to_hash}"
# 	unless Market.exists?(row.to_hash["fmid"])
# 	  Market.create!(row.to_hash)
# 	end
# end