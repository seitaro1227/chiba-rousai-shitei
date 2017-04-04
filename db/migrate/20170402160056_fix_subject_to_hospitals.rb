class FixSubjectToHospitals < ActiveRecord::Migration[5.0]
  def change
    rename_column :hospitals, :subject, :orgin_subject
  end
end
