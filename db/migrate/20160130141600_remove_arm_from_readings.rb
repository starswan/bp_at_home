class RemoveArmFromReadings < ActiveRecord::Migration
  def change
     remove_column :readings, :arm
  end
end
