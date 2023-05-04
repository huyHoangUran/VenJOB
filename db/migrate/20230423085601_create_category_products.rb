class CreateCategoryProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :category_products do |t|
      t.references :category, index:true
      t.references :product, index:true
      t.timestamps
    end
  end
end
