FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "title#{n}"}
    sequence(:content) { |n| "content#{n}"}
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "12345678" }
  end

  factory :post_category do
    title { "this is test" }
  end

end
