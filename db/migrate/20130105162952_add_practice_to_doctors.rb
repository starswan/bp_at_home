class AddPracticeToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :practice, :string
    add_column :doctors, :name, :string
  end
end
