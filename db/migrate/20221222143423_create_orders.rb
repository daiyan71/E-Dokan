class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :total_amount
      t.integer :payment_status
      t.string :response_id
      t.string :receipt_url
      t.references :user, foreign_key: true
      t.string :name
      t.string :contact_number
      t.text :address

      t.timestamps
    end
  end
end
