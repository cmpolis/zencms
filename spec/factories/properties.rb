FactoryGirl.define do
  factory :property do
    sequence(:name) { |n| "propname#{n}" }
    kind :string
    req false
  end
end
