class ChangeBenefitsColumnTypeInJobsTable < ActiveRecord::Migration[7.0]
  def up
    change_column :jobs, :benefit, :text
  end

  def down
    change_column :jobs, :benefit, :string
  end
end
