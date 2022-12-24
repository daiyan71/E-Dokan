class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.decimal :rating, precision: 10, scale: 5
      t.text :message

      t.timestamps
    end
  end
end
