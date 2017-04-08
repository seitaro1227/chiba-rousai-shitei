class AddRomanToJurisdictions < ActiveRecord::Migration[5.0]
  def change
    add_column :jurisdictions, :roman, :string
  end
end
