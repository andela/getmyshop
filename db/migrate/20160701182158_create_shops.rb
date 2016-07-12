class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.string :url
      t.string :description
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :phone
      t.references :shop_owner, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
