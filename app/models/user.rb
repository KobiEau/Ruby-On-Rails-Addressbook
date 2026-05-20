class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable, :trackable
 
  # :database_authenticatable — handles login with email/password
  # :registerable — allows users to sign up
  # :recoverable — handles forgot password flow
  # :rememberable — handles "remember me" checkbox
  # :validatable — adds email format and password length validations automatically
  # :lockable - ability to block and unblock users
  # :trackble - tracking user activity

  has_many :contacts, dependent: :destroy
  belongs_to :role, foreign_key: :role_code, primary_key: :code

  validates :firstname, presence: true
  validates :lastname,presence: true
  validates :email, presence: true, uniqueness: {case_sensitive:false}
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def fullname
    "#{firstname} #{lastname}".strip
  end

  def admin?
    role_code == "adm"
  end

  def regular_user?
    role_code == "adm"
  end

  def active?
    locked_at.nil?
  end

  def recent_contacts_count
    contacts.where("created_at > ?", 5.day.ago).count
  end

  def lock_account!
    update!(locked_at: Time.current)
  end

  def unlock_account!
    update!(locked_at: nil, failed_attempts: 0)
  end

end
