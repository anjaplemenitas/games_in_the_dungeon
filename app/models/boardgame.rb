class Boardgame < ApplicationRecord
  validates :genre, presence: true
  validates :name, presence: true
  validates :photo, presence: true
  validates :description, presence: true
  belongs_to :user
  has_one_attached :photo
end
