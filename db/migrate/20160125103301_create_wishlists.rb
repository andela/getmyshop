class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.references :user, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
