class AddReferenceToCategoriesInProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :category, index: true
  end
end
