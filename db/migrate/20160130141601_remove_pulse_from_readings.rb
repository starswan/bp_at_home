class RemovePulseFromReadings < ActiveRecord::Migration
  def change
     remove_column :readings, :pulse
  end
end
