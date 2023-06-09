class AddFieldsMyCvToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :my_cv, :string
  end
end
