class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :offers

  validates :first_name, :last_name, presence: true
  validates :user_type


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
