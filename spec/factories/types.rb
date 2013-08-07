FactoryGirl.define do
  factory :type do
    sequence(:name) { |n| "typename#{n}" }
  end
end
