FactoryBot.define do
  factory :post do
    title { "this is post" }
    content { "okkok?" }
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@gmail.com" }
    password { "12345678" }
  end

end
