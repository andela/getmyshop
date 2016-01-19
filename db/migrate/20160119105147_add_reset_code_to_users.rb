class AddResetCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_code, :string, after: :activation_token
  end
end
