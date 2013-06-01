class AddingStateToUsers < ActiveRecord::Migration
  def up

  	add_column :users, :address_state, :string
  	add_column :users, :address_city, :string
  	add_column :users, :address_street, :string
  	add_column :users, :address_zip, :integer

  end

  def down

  	remove_column :users, :address_state
  	remove_column :users, :address_city
  	remove_column :users, :address_street
  	remove_column :users, :address_zip

  end
end
