FactoryGirl.define do

  factory :script do
    sequence(:name) { |n| "scriptname#{n}" }
    content "console.log('z');"
  end

end
