class Offer < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many_attached :photos
  has_many :bookings
  has_many :reviews, dependent: :destroy

  belongs_to :user

  validates :category, :title, :description, :price, :address, presence: true

  validates :category, inclusion: { in: ['Bicycle', 'Skateboard', 'Scooter', 'Rollerblades'] }

  validates :price, numericality: { only_integer: true }

  validates :description, length: { in: 10..800 }, allow_blank: false

  validates :title, length: { in: 10..100 }, allow_blank: false

  validates :price, numericality: { greater_than_or_equal_to: 1}, allow_blank: false

  validates :optional, inclusion: { in: ['None', 'Padlock', 'Backseat'] }

  validates :electric, :safety_equipment, inclusion: { in: [true, false] }, allow_blank: false

  include PgSearch::Model
  pg_search_scope :search_by_title_and_description,
                  against: %i[title description],
                  using: {
                    tsearch: { prefix: true }
                  }

  pg_search_scope :search_by_address,
                  against: [:address],
                  using: {
                    tsearch: { prefix: true }
                  }

  pg_search_scope :search_by_electric,
                  against: [:electric],
                  using: {
                    tsearch: { prefix: true }
                  }
  pg_search_scope :search_by_optional,
                  against: [:optional],
                  using: {
                    tsearch: { prefix: true }
                  }
  pg_search_scope :search_by_safety_equipment,
                  against: [:safety_equipment],
                  using: {
                    tsearch: { prefix: true }
                  }
end
