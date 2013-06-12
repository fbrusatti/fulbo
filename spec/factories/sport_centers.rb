# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sport_center do
    name "MyString"
    cuit "MyString"
    phone "MyString"
    email { FactoryGirl.generate :email }
    address "MyString"
    description "MyString"
  end
end
