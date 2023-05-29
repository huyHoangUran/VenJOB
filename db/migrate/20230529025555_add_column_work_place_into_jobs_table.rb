class AddColumnWorkPlaceIntoJobsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :work_place, :string
  end
end
