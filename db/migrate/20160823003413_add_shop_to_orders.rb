class AddShopToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :shop, index: true, foreign_key: true
  end
end
