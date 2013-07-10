# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sport_center do
    sequence(:name)  { |n| "Sport Center #{n}" }
    sequence(:cuit)  { |n| "cuit#{n}" }
    phone            "MyString"
    email            { FactoryGirl.generate :email }
    address          "MyString"
    description      "MyString"
  end
end
