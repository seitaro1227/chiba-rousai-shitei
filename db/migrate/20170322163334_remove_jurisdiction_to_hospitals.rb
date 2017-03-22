class RemoveJurisdictionToHospitals < ActiveRecord::Migration[5.0]
  def change
    remove_column(:hospitals, :jurisdiction)
  end
end
