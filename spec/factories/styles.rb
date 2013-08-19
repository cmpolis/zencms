FactoryGirl.define do

  factory :style do
    sequence(:name) { |n| "stylename#{n}" }
    content "body { color: red; }"

    factory :referenced_css do
      name 'stylesheet-reference'
      reference_url 'https://raw.github.com/dhg/Skeleton/master/stylesheets/skeleton.css'
    end
  end

end
