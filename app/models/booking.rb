class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :offer

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :description, uniqueness: { scope: :title,
    message: "There is already an offer with this tittle and description." }
end
