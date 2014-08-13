FactoryGirl.define do
  factory :wiki do
    sequence(:title, 100) { |n| "Unique title: #{n}" }
    sequence(:body, 100) { |n| "Here's some unique body content: #{n}" }
  end
end