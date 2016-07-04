class CreateShopOwners < ActiveRecord::Migration
  def change
    create_table :shop_owners do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.string :password_digest
      t.string :activation_token
      t.boolean :active_status
      t.string :reset_code
      t.boolean :active

      t.timestamps null: false
    end
  end
end
