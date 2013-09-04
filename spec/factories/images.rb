FactoryGirl.define do

  factory :image do
    sequence(:name) { |n| "imagename#{n}" }
    file { Rack::Test::UploadedFile.new(File.join(%w(spec support placekitten.jpeg).unshift(Rails.root))) } 
  end

end
