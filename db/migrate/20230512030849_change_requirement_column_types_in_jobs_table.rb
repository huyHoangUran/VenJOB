class ChangeRequirementColumnTypesInJobsTable < ActiveRecord::Migration[7.0]
  def change
    change_column :jobs, :requirement, :string, limit: 1000
  end
end
