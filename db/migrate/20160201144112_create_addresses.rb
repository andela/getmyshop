class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :email
      t.string :address
      t.string :landmark
      t.string :gender
      t.string :phone
      t.string :state
      t.string :city
      t.string :country

      t.timestamps null: false
    end
  end
end
