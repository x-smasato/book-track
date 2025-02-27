class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reading_statuses, dependent: :destroy
  has_many :books, through: :reading_statuses

  validates :name, presence: true
end
