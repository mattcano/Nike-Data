class AddDurationStrToRun < ActiveRecord::Migration
  def change
    add_column :runs, :duration_str, :string
  end
end
