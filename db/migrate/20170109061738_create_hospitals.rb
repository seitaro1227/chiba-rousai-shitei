class CreateHospitals < ActiveRecord::Migration[5.0]
  def change
    create_table :hospitals do |t|
      t.string :jurisdiction
      t.string :number
      t.string :name
      t.string :zip_code
      t.string :address
      t.string :subject
      t.string :saikei
      t.string :niji
      t.string :phone_number
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
