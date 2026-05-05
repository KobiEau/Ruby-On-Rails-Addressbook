class AddCategoryToContacts < ActiveRecord::Migration[8.1]
  def change
    add_column :contacts, :category, :string, default: "Uncategorised"
  end
end
