class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, uniqueness: true, allow_blank: true
  validates :total_pages, numericality: { greater_than: 0, only_integer: true }, allow_nil: true
end
