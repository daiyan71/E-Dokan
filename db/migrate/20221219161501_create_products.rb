class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :product_category, foreign_key: true
      t.boolean :available
      t.string :name
      t.string :image
      t.decimal :price, precision: 10, scale: 5
      t.integer :quantity
      t.text :description

      t.timestamps
    end
  end
end
