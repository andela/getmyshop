class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_number, index: true
      t.string :payment_method
      t.decimal :total_amount
      t.references :user, index: true, foreign_key: true
      t.references :address, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
