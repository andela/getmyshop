class RemoveUsernameFromOauthAccount < ActiveRecord::Migration
  def change
    remove_column :oauth_accounts, :username
  end
end
