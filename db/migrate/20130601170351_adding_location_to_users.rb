class AddingLocationToUsers < ActiveRecord::Migration
  def up

  	add_column :users, :raw_location, :string
  	add_column :users, :lat, :float
  	add_column :users, :lng, :float

  end

  def down

  	remove_column :users, :raw_location
  	remove_column :users, :lat
  	remove_column :users, :lng

  end
end
