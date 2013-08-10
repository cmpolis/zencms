FactoryGirl.define do

  factory :style do
    sequence(:name) { |n| "stylename#{n}" }
    content "body { color: red; }"
  end

end
