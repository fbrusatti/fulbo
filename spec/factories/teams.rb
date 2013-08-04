# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    sequence(:name)  { |n| " Team- #{n}" }
    captain 1
  end
end
