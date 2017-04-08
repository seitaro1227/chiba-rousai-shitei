class AddJurisdictionIdToHospitals < ActiveRecord::Migration[5.0]
  def change
    add_column :hospitals, :jurisdiction_id, :integer
  end
end
