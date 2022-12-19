class AddAdditionalColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_name, :string
    add_column :users, :image, :string
    add_column :users, :contact_number, :integer
    add_column :users, :is_admin, :boolean
  end
end
