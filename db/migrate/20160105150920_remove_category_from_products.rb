class RemoveCategoryFromProducts < ActiveRecord::Migration
  def change
    remove_reference :products, :category, index: true
  end
end
