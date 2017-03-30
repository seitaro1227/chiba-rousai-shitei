class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
      t.string :code
      t.string :name
      t.string :short_name

      t.timestamps
    end
  end
end
