class ReadingStatus < ApplicationRecord
  STATUSES = {
    want_to_read: 0,
    currently_reading: 1,
    completed: 2
  }.freeze

  belongs_to :user
  belongs_to :book

  enum :status, STATUSES

  validates :status, presence: true
  validates :user_id, uniqueness: { scope: :book_id }
  validate :completion_date_after_start_date, if: -> { start_date.present? && completion_date.present? }

  private

  def completion_date_after_start_date
    if completion_date < start_date
      errors.add(:completion_date, :invalid)
    end
  end
end
