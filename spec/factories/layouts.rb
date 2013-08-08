FactoryGirl.define do
  factory :layout do
    sequence(:name) { |n| "layoutname#{n}" }
    content "<h1>{{ object.name }}</h1>"
  end
end
