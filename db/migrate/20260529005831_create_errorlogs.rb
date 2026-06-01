class CreateErrorlogs < ActiveRecord::Migration[8.1]
  def change
    create_table :error_logs do |t|
      t.string :error_class, null: false
      t.text :message,       null:false
      t.string :path
      t.string :http_method
      t.integer :user_id
      t.string :ip_address
      t.integer :occurrences, default: 1, null: false
      t.datetime :last_occured_at

      t.timestamps
    end

    add_index :error_logs, :error_class
    add_index :error_logs, :user_id
    add_index :error_logs, :created_at
  end
end
