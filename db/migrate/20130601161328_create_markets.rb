class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets, :primary_key => :fmid do |t|
      t.integer :fmid
      t.string :market_name
      t.string :website
      t.string :street
      t.string :city
      t.string :county
      t.string :state
      t.string :zip
      t.string :schedule
      t.float :x
      t.float :y
      t.string :location
      t.string :credit
      t.string :wic
      t.string :wic_cash
      t.string :sfmnp
      t.string :snap
      t.string :bakedgoods
      t.string :cheese
      t.string :crafts
      t.string :flowers
      t.string :eggs
      t.string :seafood
      t.string :herbs
      t.string :vegetables
      t.string :honey
      t.string :jams
      t.string :maple
      t.string :meat
      t.string :nursery
      t.string :nuts
      t.string :plants
      t.string :poultry
      t.string :prepared
      t.string :soap
      t.string :trees
      t.string :wine
      t.string :update_time

      t.timestamps
    end
  end
end
