class AddColumnCompanyIdIntoJobsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :company_id, :string
  end
end
