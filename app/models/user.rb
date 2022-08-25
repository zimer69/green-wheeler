class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :offers
  has_many :bookings
  has_many :bookings_as_owner, through: :offers, source: :bookings

  validates :first_name, :last_name, presence: true
  validates :first_name, :last_name, length: { minimum: 3 }, allow_blank: false

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
