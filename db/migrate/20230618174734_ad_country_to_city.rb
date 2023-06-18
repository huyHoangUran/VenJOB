class AdCountryToCity < ActiveRecord::Migration[7.0]
  def change
    add_column :cities, :country, :string
  end
end
