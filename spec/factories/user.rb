FactoryGirl.define do
  factory :user do
    sequence(:email, 100) { |n| "email#{n}@fake.com" }
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now
  end
end