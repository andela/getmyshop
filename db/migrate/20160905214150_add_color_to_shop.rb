class AddColorToShop < ActiveRecord::Migration
  def change
    add_column :shops, :color, :string
  end
end
