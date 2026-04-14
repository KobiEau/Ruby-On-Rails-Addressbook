class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :contacts, dependent: :destroy
  validates :firstname, presence: true
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def fullname
    "#{firstname} #{lastname}".strip
  end
end
