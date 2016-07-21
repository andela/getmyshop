class AddDefaultValueToActive < ActiveRecord::Migration
  def change
    change_column :shop_owners, :active, :boolean, default: true
  end
end
