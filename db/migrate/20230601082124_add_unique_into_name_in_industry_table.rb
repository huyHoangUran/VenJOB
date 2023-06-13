class AddUniqueIntoNameInIndustryTable < ActiveRecord::Migration[7.0]
  def change
    add_index :industries, :name, unique: true
  end
end
