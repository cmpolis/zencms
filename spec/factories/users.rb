FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "testuseremail#{n}@test.com" }
    sequence(:username) { |n| "testuser#{n}" }
    password 'foobar123'
    password_confirmation 'foobar123'
  end
end
