class Book < ApplicationRecord
  FORMATS = %w[physical kindle audiobook ebook].freeze

  belongs_to :related_book, class_name: "Book", optional: true
  has_many :related_editions, class_name: "Book", foreign_key: "related_book_id"

  has_many :reading_statuses, dependent: :destroy
  has_many :users, through: :reading_statuses

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, uniqueness: true, allow_blank: true
  validates :total_pages, numericality: { greater_than: 0, only_integer: true }, allow_nil: true
  validates :format, inclusion: { in: FORMATS }, allow_nil: true

  validate :no_circular_references
  
  # Ransack設定（ActiveAdmin用）
  def self.ransackable_attributes(auth_object = nil)
    ["author", "created_at", "description", "format", "id", "isbn", "published_date", 
     "publisher", "related_book_id", "title", "total_pages", "updated_at"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["related_book", "related_editions", "reading_statuses", "users"]
  end

  private

  def no_circular_references
    # Check for direct self-reference (book referencing itself)
    if related_book_id.present? && related_book_id == id
      errors.add(:related_book, "cannot create circular reference")
      return
    end

    # Check for circular reference (book1 -> book2 -> book1)
    if related_book.present? && related_book.related_book_id.present? && related_book.related_book_id == id
      errors.add(:related_book, "cannot create circular reference")
    end
  end
end
