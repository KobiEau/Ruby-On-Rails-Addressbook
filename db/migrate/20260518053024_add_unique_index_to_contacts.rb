class AddUniqueIndexToContacts < ActiveRecord::Migration[8.1]
  def change
    add_index :contacts, [:firstname,:lastname,:phone_number, :user_id],
              unique:true,
              name:"index_contacts_on_name_and_phone_and_user"
  end
end
