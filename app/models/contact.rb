class Contact < ApplicationRecord
  belongs_to :user
  validates :firstname,:lastname, presence: true ,length: {minimum: 1}
  validates :phone_number, format:{
    with: /\A0[253]\d{8}\z/,
    message: "must be 10-digit number starting with 02,03 or 05"
  }

  def fullname
    [firstname,lastname].compact.join(" ")
  end
end
