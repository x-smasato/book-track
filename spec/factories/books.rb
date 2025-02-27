FactoryBot.define do
  factory :book do
    title { "Ruby on Rails入門" }
    author { "山田太郎" }
    sequence(:isbn) { |n| "978-4-1234-5678-#{n}" }
    published_date { "2025-02-27" }
    total_pages { 350 }
    description { "Railsの基本から応用までを解説した入門書です。" }
    publisher { "技術書出版社" }
    format { "physical" }
    related_book { nil }
  end
end
