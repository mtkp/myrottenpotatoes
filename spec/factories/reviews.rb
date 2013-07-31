# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    movie
    moviegoer
    potatoes  3
  end
end
