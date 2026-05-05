class CreateRoles < ActiveRecord::Migration[8.1]
  def change
    create_table :roles, id: false, primary_key: :code do |t|
      t.string :code, primary_key: true #"usr" or "adm" as the primary key
      t.string :name, null: false #"User" or "Administrator"
      t.timestamps
    end
  end
end
