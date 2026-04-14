class AddNameToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
  end
end
