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
  validates :rating, :min_players, :max_players, :min_playtime, :max_playtime, :age_rating, :genre, presence: true
  validates :rating, numericality: { in: 1..5 }
  belongs_to :user
  has_one_attached :photo
end
