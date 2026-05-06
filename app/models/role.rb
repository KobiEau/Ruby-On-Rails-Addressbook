class Role < ApplicationRecord
  self.primary_key = "code" #Tell Rails the PK is the code not default "id"

  has_many :users, foreign_key: :role_code, primary_key: :code

  ADMIN = "adm"
  USER = "usr"

  # Constants so we never hardcode "adm"/"usr" strings
  # anywhere else in the app — we use Role::ADMIN instead
end