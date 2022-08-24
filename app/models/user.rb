class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :offers

  validates :first_name, :last_name, presence: true
  validates :first_name, :last_name, length: { minimum: 3 }, allow_blank: false

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
