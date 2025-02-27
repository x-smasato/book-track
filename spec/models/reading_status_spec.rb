require 'rails_helper'

RSpec.describe ReadingStatus, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      reading_status = build(:reading_status)
      expect(reading_status).to be_valid
    end

    it 'is not valid without a status' do
      reading_status = build(:reading_status, status: nil)
      expect(reading_status).not_to be_valid
      expect(reading_status.errors[:status]).to be_present
    end

    it 'is not valid without a user' do
      reading_status = build(:reading_status, user: nil)
      expect(reading_status).not_to be_valid
      expect(reading_status.errors[:user]).to be_present
    end

    it 'is not valid without a book' do
      reading_status = build(:reading_status, book: nil)
      expect(reading_status).not_to be_valid
      expect(reading_status.errors[:book]).to be_present
    end

    it 'is not valid with a duplicate user and book combination' do
      user = create(:user)
      book = create(:book)
      create(:reading_status, user: user, book: book)

      reading_status = build(:reading_status, user: user, book: book)
      expect(reading_status).not_to be_valid
      expect(reading_status.errors[:user_id]).to be_present
    end

    it 'is not valid when completion_date is before start_date' do
      reading_status = build(:reading_status, start_date: Date.current, completion_date: 1.day.ago)
      expect(reading_status).not_to be_valid
      expect(reading_status.errors[:completion_date]).to be_present
    end
  end

  describe 'enum status' do
    it 'defines the correct statuses' do
      expect(ReadingStatus.statuses.keys).to match_array(%w[want_to_read currently_reading completed])
    end

    it 'defaults to want_to_read status' do
      reading_status = create(:reading_status)
      expect(reading_status.status).to eq('want_to_read')
    end
  end

  describe 'factory traits' do
    it 'creates a currently_reading status with start_date' do
      reading_status = create(:reading_status, :currently_reading)
      expect(reading_status.status).to eq('currently_reading')
      expect(reading_status.start_date).to be_present
      expect(reading_status.completion_date).to be_nil
    end

    it 'creates a completed status with start_date and completion_date' do
      reading_status = create(:reading_status, :completed)
      expect(reading_status.status).to eq('completed')
      expect(reading_status.start_date).to be_present
      expect(reading_status.completion_date).to be_present
    end
  end
end
