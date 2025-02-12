FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    description { '私についての説明文です。' }
    sequence(:email) { |n| "user\#{n}@example.com" }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end
