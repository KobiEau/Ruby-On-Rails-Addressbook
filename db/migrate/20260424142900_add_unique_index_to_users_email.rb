class AddUniqueIndexToUsersEmail < ActiveRecord::Migration[8.1]
  def change
    add_index :users, :email_address, unique:true,if_not_exists: true
  end
end
