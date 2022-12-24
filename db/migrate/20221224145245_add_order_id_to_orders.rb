class AddOrderIdToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_number, :string
  end
end
