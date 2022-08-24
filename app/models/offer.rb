class Offer < ApplicationRecord
  belongs_to :user

  validates :category, :title, :description, :price_in_cents, presence: true

  validates :category, inclusion: { in: ['Bicycle', 'Skateboard', 'Scooter', 'Rollerblades'] }

  validates :price_in_cents, numericality: { only_integer: true }

  # validates :rating, length: { in: 0..5 }

  validates :description, length: { in: 10..300 }, allow_blank: false

  validates :title, length: { in: 10..30 }, allow_blank: false

  validates :price_in_cents, numericality: { greater_than_or_equal_to: 100 }, allow_blank: false

  validates :optional, inclusion: { in: ['None', 'Padlock', 'Backseat'] }

  validates :electric, :safety_equipment, inclusion: { in: [true, false] }, allow_blank: false
end
