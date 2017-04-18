class AddIndexToSubjectsNameAndCode < ActiveRecord::Migration[5.0]
  def change
    add_index :subjects, :name, unique: true
    add_index :subjects, :code, unique: true
  end
end
