FactoryGirl.define do
  factory :user do
    sequence(:first_name, 100) { |n| "First#{n}" }
    sequence(:last_name, 100) { |n| "Last#{n}" }
    password "helloworld"
  end
end