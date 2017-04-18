class AddIndexToJurisdictionsNameAndRoman < ActiveRecord::Migration[5.0]
  def change
    add_index :jurisdictions, :name,  unique: true
    add_index :jurisdictions, :roman, unique: true
  end
end
