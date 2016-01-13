class CreateOauthAccounts < ActiveRecord::Migration
  def change
    create_table :oauth_accounts do |t|
      t.string :provider
      t.string :uid
      t.string :oauth_secret
      t.string :oauth_token
      t.string :username
      t.datetime :oauth_expires
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
