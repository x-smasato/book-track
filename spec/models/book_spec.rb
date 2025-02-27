require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it 'is valid with all attributes' do
      book = build(:book)
      expect(book).to be_valid
    end

    it 'is invalid without a title' do
      book = build(:book, title: nil)
      expect(book).not_to be_valid
      expect(book.errors[:title]).to be_present
    end

    it 'is invalid without an author' do
      book = build(:book, author: nil)
      expect(book).not_to be_valid
      expect(book.errors[:author]).to be_present
    end

    it 'is valid without an isbn' do
      book = build(:book, isbn: nil)
      expect(book).to be_valid
    end

    it 'is invalid with a duplicate isbn' do
      create(:book, isbn: '978-4-1234-5678-0')
      book = build(:book, isbn: '978-4-1234-5678-0')
      expect(book).not_to be_valid
      expect(book.errors[:isbn]).to be_present
    end

    it 'is invalid with a non-positive total_pages' do
      book = build(:book, total_pages: 0)
      expect(book).not_to be_valid
      expect(book.errors[:total_pages]).to be_present
    end

    it 'is invalid with a non-integer total_pages' do
      book = build(:book, total_pages: 10.5)
      expect(book).not_to be_valid
      expect(book.errors[:total_pages]).to be_present
    end

    it 'is valid without total_pages' do
      book = build(:book, total_pages: nil)
      expect(book).to be_valid
    end
  end
end
