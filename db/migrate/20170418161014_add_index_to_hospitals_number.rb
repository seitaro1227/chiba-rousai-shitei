class AddIndexToHospitalsNumber < ActiveRecord::Migration[5.0]
  def change
    add_index :hospitals, :number, unique: true
  end
end
