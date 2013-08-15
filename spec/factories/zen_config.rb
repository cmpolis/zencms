FactoryGirl.define do

  factory :zen_config do
    ga_tracking_id 'UA-23674172-1'
    ga_enabled true
    base_url 'http://localhost:3000'
    twitter_handle 'chrispolis'
    admin_email 'admin@zencmstest.com'
  end

end
