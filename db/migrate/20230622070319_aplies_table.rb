class ApliesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :applies do |t|
      t.integer :user_id
      t.string :fullname
      t.string :email
      t.string :cv                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
      t.integer :job_id
      t.timestamps
    end
  end
end
