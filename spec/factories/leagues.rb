# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :league do
    sequence(:name)  { |n| "Apertura #{n}" }
    category [5]
    start_date "12/12/2012"
    number_teams 10
    number_matches 20
  end
end
