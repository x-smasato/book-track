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

  describe 'format validation' do
    it 'is valid with a valid format' do
      Book::FORMATS.each do |format|
        book = build(:book, format: format)
        expect(book).to be_valid
      end
    end

    it 'is invalid with an invalid format' do
      book = build(:book, format: 'invalid_format')
      expect(book).not_to be_valid
      expect(book.errors[:format]).to be_present
    end

    it 'is valid without a format' do
      book = build(:book, format: nil)
      expect(book).to be_valid
    end
  end

  describe 'related_book association' do
    it 'can have a related book' do
      parent_book = create(:book)
      child_book = create(:book, related_book: parent_book)
      expect(child_book.related_book).to eq(parent_book)
      expect(parent_book.related_editions).to include(child_book)
    end

    it 'prevents circular references' do
      book1 = create(:book)
      book2 = create(:book, related_book: book1)
      book1.related_book = book2
      expect(book1).not_to be_valid
      expect(book1.errors[:related_book]).to be_present
    end
  end
end
