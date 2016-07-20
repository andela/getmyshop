class AddDefaultValueToVerifiedAttribute < ActiveRecord::Migration
  def change
    change_column :shop_owners, :verified, :boolean, default: false
  end
end
