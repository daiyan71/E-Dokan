class AddRatingColumnsToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :current_rating, :decimal, precision: 10, scale: 5
    add_column :products, :rating_count, :integer
  end
end
