class AddShopToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :shop, index: true, foreign_key: true
  end
end
