class AddScheduleToMarkets < ActiveRecord::Migration
  def change
    add_column :markets, :schedule, :text
  end
end
