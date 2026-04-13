class RenamePhoneToPhoneNumberInContacts < ActiveRecord::Migration[8.1]
  def change
    rename_column :contacts, :phone, :phone_number
  end
end
