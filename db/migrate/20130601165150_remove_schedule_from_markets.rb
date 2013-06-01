class RemoveScheduleFromMarkets < ActiveRecord::Migration
  def up
    remove_column :markets, :schedule
  end

  def down
    add_column :markets, :schedule, :string
  end
end
