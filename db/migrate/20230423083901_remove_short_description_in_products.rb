class RemoveShortDescriptionInProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :short_description, :string
  end
end
