class AddActivationTokenAndActiveStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_token, :string, after: :password_digest
    add_column :users, :active_status, :boolean, after: :activation_token
  end
end
