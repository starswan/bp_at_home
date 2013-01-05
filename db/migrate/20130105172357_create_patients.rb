class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.integer :doctor_id
      t.string :identifier

      t.timestamps
    end
    
    add_index :patients, :doctor_id
  end
end
