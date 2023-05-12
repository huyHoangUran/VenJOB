class ChangeRequirementColumnTypessInJobsTable < ActiveRecord::Migration[7.0]
  
    def change
      change_column :jobs, :requirement, :text
    end
  
end
