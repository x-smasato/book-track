# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# テスト用の書籍データ
books_data = [
  {
    title: "Ruby on Rails 7実践ガイド",
    author: "山田太郎",
    isbn: "9784123456789",
    published_date: Date.new(2023, 1, 15),
    total_pages: 350,
    description: "Ruby on Rails 7の基本から応用までを解説した実践的なガイドブック。",
    publisher: "技術書出版",
    format: "physical"
  },
  {
    title: "実践JavaScript",
    author: "鈴木一郎",
    isbn: "9784567890123",
    published_date: Date.new(2022, 6, 10),
    total_pages: 280,
    description: "モダンJavaScriptの実践的な使い方を解説した一冊。",
    publisher: "Webプログラミング社",
    format: "ebook"
  },
  {
    title: "PostgreSQLデータベース設計",
    author: "佐藤花子",
    isbn: "9784321098765",
    published_date: Date.new(2023, 3, 20),
    total_pages: 420,
    description: "PostgreSQLを使ったデータベース設計のベストプラクティスを紹介。",
    publisher: "DB技術出版",
    format: "physical"
  }
]

# 書籍データの登録
books_data.each do |book_data|
  Book.find_or_create_by!(isbn: book_data[:isbn]) do |book|
    book.attributes = book_data
  end
end

puts "#{Book.count}冊の書籍データを登録しました。"
AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password") if Rails.env.development?
