class RenameColumnTypeToTypeWorkIntoJobsTabls < ActiveRecord::Migration[7.0]
  def change
    rename_column :jobs, :type, :type_work
  end
end
