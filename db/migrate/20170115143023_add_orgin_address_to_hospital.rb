class AddOrginAddressToHospital < ActiveRecord::Migration[5.0]
  def change
    add_column :hospitals, :orgin_address, :string
  end
end
