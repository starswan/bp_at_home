class AddArmsToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :arm, :string
  end
end
