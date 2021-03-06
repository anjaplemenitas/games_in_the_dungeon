class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :boardgames
  has_many :bookings

  # validates :username, uniqueness: true, presence: true, length: { minimum: 6 }
  # validates :address, presence: true
end
