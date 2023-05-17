class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :benefit
      t.string :company_address
      t.string :company_district
      t.string :company_name
      t.text :description
      t.string :level
      t.string :name
      t.text :requirement
      t.string :salary
      t.string :type
      t.string :contact_email
      t.string :contact_name
      t.string :contact_phone
      t.integer :industry_id
      t.integer :work_place_id
      t.timestamps
    end
  end
end
