class AddTimeToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :time, :time
  end
end
