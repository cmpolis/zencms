FactoryGirl.define do

  factory :collection do
    sequence(:name) { |n| "testcol#{n}" }
  end

end
