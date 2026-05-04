class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :contacts, dependent: :destroy
  validates :firstname, presence: true
  validates :email_address, presence: true, uniqueness: {case_sensitive:false}
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def fullname
    "#{firstname} #{lastname}".strip
  end
end
