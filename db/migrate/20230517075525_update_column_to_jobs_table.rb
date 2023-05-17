class UpdateColumnToJobsTable < ActiveRecord::Migration[7.0]
  def change
    change_column :jobs, :benefit, :text
    change_column :jobs, :requirement, :text
    change_column :jobs, :salary, :text
  end
end
