class ChangeLevelColumnTypeInJobsTable < ActiveRecord::Migration[7.0]
  def change
    change_column :jobs, :level, :text
  end
end
