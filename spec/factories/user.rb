FactoryGirl.define do
  factory :user do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password              "santanu"
    password_confirmation "santanu"
  end
end
