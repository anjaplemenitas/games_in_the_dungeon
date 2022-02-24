class Boardgame < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_name_and_genre,
  against: [ :name, :genre ],
  using: {
    tsearch: { prefix: true }
  }

  GENRES = ['Abstract Strategy',
       'Action Drafting',
       'Area Control',
       'Bluffing',
       'Card Drafting',
       'Cooperative',
       'Deckbuilding',
       'Dexterity',
       'Engine Building',
       'Eurogame',
       'Legacy',
       'Miniature',
       'Party',
       'Roleplaying',
       'Roll and Write',
       'Storytelling',
       'Tile Placement',
       'Trading Card',
       'Trick Taking',
       'Wargame',
       'Worker Placement']

  validates :genre, inclusion: { in: GENRES }
  validates :name, presence: true
  validates :photo, presence: true
  validates :description, presence: true
  belongs_to :user
  has_one_attached :photo
end
