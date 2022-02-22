class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
<<<<<<< HEAD
  has_many :boardgames, through: :bookings
=======

  has_many :boardgames
>>>>>>> c5ff4b64df627f4c1338cd512aaef1ee30af0a88
end
