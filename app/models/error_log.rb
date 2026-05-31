class ErrorLog < ApplicationRecord
  belongs_to :user, optional: true
  #true,,, errors can happen when no one is logged in
  
  scope :recent, ->{order(last_occurred_at: :desc)}
  scope :frequent, ->{order(occurrences: :desc)}
end
