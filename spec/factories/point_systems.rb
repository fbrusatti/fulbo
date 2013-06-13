# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :point_system do
    win "3"
    tie "1"
    loser "0"
  end
end
