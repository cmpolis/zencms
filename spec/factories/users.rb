# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'abc123@test123.com'
    password 'foobar123'
    password_confirmation 'foobar123'
  end
end
