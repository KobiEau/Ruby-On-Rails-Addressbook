class AddUserIdToContacts < ActiveRecord::Migration[8.1]
  def change
    add_column :contacts, :user_id, :bigint, null: true
    add_index :contacts, :user_id
    add_foreign_key :contacts, :users
  end
end
