class ChangeColumTypeIntoJobsTable < ActiveRecord::Migration[7.0]
  def change
    change_column :jobs, :type, :text
  end
end
