class AddColumnToJobsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :company_province, :string
  end
end
