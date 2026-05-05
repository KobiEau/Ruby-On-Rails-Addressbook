class AddRoleCodeToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role_code, :string, null: false,default:"usr"
    # null: false  — every user MUST have a role, no exceptions
    # default: "usr" — unless specified, new signups are regular users automatically
    
    add_foreign_key :users, :roles,
                    column: :role_code, # column in users table
                    primary_key: :code  #references roles.code not roles.id

    add_index :users, :role_code #index speeds up queries 

    #Add user FK to contacts
    #add_foreign_key :contacts, :users
    #add_index :contacts, :user_id
  end
end
