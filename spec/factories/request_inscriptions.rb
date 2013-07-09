# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :request_inscription do
    requester_id 1
    requester_type "MyString"
    requested_id 1
    requested_type "MyString"
  end
end
