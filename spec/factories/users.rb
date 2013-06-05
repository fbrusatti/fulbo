FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    sequence(:name)  { |n| "User N#{n}" }
    email            { FactoryGirl.generate :email }
    password         'password'
  end
end
