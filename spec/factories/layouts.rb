FactoryGirl.define do

  factory :layout do
    sequence(:name) { |n| "layoutname#{n}" }
    content "<h1>{{ object.name }}</h1>"

    factory :fullpage_layout do
      content "<!DOCTYPE html><html><head></head>
               <body><h1>{{ mytype.name }}</h1>
               <p>Color: {{ mytype.color }}</p>
               </body></html>"
    end

    factory :static_layout do
      content "<!DOCTYPE html><html><head></head>
               <body><h1>This is a static -> static_content</h1>
               </body></html>"
    end
  end
end
