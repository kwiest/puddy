FactoryGirl.define do
  factory :account do
    sequence(:name) { |n| "Oregon Football ##{n}" }
    primary_email 'ofc@example.com'
  end
end
