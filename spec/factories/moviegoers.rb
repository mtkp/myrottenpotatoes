# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :moviegoer do
    sequence(:name) { |n| "Person #{n}" }
    provider "twitter"
    sequence(:uid) { |n| "000#{n}" }
  end
end
