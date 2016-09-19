class ChangeColorColumnOnShops < ActiveRecord::Migration
  def change
    change_column :shops, :color, :string, default: 'black'
  end
end
