class AddBrandToProduct < ActiveRecord::Migration
  def change
    add_column :products, :brand, :string
  end
end
