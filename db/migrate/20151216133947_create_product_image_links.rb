class CreateProductImageLinks < ActiveRecord::Migration
  def change
    create_table :product_image_links do |t|
      t.string :link_name
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
