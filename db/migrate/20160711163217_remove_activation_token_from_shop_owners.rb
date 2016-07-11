class RemoveActivationTokenFromShopOwners < ActiveRecord::Migration
  def change
    remove_column :shop_owners, :activation_token, :string
  end
end
