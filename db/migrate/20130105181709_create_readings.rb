class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.integer :systolic
      t.integer :diastolic
      t.integer :pulse
      t.integer :patient_id

      t.timestamps
    end

    add_index :readings, :patient_id
  end
end
