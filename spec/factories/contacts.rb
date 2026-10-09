FactoryBot.define do
  factory :contact do
    firstname { "test" }
    lastname  { "contact" }
    phone_number { "233251234567" }
    category     { "Friends" }
    association  :user
  end
end
