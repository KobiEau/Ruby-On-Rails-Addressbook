FactoryBot.define do
  factory :user do
    firstname { "test" }
    lastname  { "user" }
    sequence(:email)   { |n| "testuser#{n}@test.com" }
    password  { "test123" }
    # association :role, code: "usr", name: "User"

    after(:build) do |user|
      user.role = Role.find_or_create_by(code: "usr") do |r|
        r.name = "User"
      end
    end
  end
end
