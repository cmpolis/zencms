FactoryGirl.define do
  factory :static do
    sequence(:name) { |n| "typename#{n}" }
    sequence(:path) { |n| "staticpath#{n}" }
  end
end
