class AddSpeedToRun < ActiveRecord::Migration
  def change
    add_column :runs, :speed, :float
  end
end
