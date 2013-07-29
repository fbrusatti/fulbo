
FactoryGirl.define do
  factory :field do
    sequence(:name)  { |n| "El Monumental#{n}" }
    surface "parquet"
    category "[5]"
  end
end
