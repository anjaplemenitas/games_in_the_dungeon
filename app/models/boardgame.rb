class Boardgame < ApplicationRecord
  validates :genre, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name_and_genre,
  against: [ :name, :genre ],
  using: {
    tsearch: { prefix: true }
  }
  
  validates :name, presence: true
  validates :photo, presence: true
  validates :description, presence: true
  belongs_to :user
  has_one_attached :photo
end
