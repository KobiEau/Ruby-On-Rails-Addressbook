class Contact < ApplicationRecord
  belongs_to :user

  CATEGORIES = %w[Uncategorised Family Friends Work Colleagues].freeze

  validates :firstname,:lastname, presence: true ,length: {minimum: 1}
  validates :phone_number, presence: true,
  format:{
    with: /\A0[253]\d{8}\z/,
    message: "must be 10-digit number starting with 02,03 or 05"
  }
  validates :category, inclusion:{
    #inclusion keyword validates only values from an accepted list
    in: CATEGORIES,
    message: "must be a valid category"
  }

  validates :firstname,
  uniqueness:{
    scope: [:lastname,:phone_number, :user_id],
    message: "already has a contact with this name and number"
  }

  def fullname
    [firstname,lastname].compact.join(" ")
  end

  
end
