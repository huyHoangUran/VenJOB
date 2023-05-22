class RenameCityIdToWorkPlaceIdInJobs < ActiveRecord::Migration[7.0]
  def change
    rename_column :jobs, :work_place_id, :city_id
  end
end
