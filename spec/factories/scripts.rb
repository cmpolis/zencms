FactoryGirl.define do

  factory :script do
    sequence(:name) { |n| "scriptname#{n}" }
    content "console.log('z');"

    factory :jquery do
      name 'jquery-reference'
      content nil
      reference_url '//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js'
    end
  end

end
