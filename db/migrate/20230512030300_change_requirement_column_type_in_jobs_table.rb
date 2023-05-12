class ChangeRequirementColumnTypeInJobsTable < ActiveRecord::Migration[7.0]
  def change
    def up
      change_column :jobs, :requirement, :text
    end
  
    def down
      change_column :jobs, :requirement, :string
    end
  end
end
