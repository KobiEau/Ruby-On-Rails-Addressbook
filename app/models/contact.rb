class Contact < ApplicationRecord
  belongs_to :user
  validates :firstname,:lastname, presence: true ,length: {minimum: 1}
  validates :phone_number, presence: true, numericality:{greater_than:0}
end
