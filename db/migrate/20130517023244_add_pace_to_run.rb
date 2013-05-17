class AddPaceToRun < ActiveRecord::Migration
  def change
    add_column :runs, :pace, :float
  end
end
