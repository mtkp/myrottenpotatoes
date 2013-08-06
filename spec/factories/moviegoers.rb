# generate a moviegoer

FactoryGirl.define do
  factory :moviegoer do
    sequence(:name) { |n| "Person #{n}" }
    provider "twitter"
    sequence(:uid) { |n| "000#{n}" }

    # generate a moviegoer that is an administrator
    factory :admin do
      admin true
    end
  end
end
