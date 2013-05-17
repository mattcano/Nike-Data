class AddPaceStrToRun < ActiveRecord::Migration
  def change
    add_column :runs, :pace_str, :string
  end
end
