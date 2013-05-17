class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.string :name
      t.string :device
      t.datetime :start
      t.float :duration
      t.float :distance
      t.integer :calories
      t.integer :steps

      t.timestamps
    end
  end
end
