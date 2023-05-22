class AddJobCountIntoIndustriesTable < ActiveRecord::Migration[7.0]
  def change
    add_column :industries, :job_count, :integer
  end
end
