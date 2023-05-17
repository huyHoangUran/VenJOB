class CreateWorkPlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :work_places do |t|
      t.string :name
      t.timestamps
    end
  end
end
