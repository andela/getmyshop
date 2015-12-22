class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :price
      t.text :description
      t.integer :quantity
      t.string :code

      t.timestamps null: false
    end
  end
end
