class Contact < ApplicationRecord
  validates :firstname,:lastname, presence: true ,length: {minimum: 1}
  validates :phone_number, presence: true
end
