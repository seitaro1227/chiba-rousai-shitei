class CreateHospitalSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :hospital_subjects do |t|
      t.references :hospital, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
