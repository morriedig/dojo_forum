FactoryBot.define do
  factory :post do
    title { "this is post" }
    content { "okkok?" }
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "12345678" }
  end

  factory :post_category do
    title { "this is test" }
  end

end
