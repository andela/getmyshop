class RenameActiveStatusToVerified < ActiveRecord::Migration
  def change
    rename_column :shop_owners, :active_status, :verified
    rename_column :users, :active_status, :verified
  end
end
