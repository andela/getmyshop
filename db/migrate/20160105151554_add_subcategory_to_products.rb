class AddSubcategoryToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :subcategory, index: true, foreign_key: true
  end
end
