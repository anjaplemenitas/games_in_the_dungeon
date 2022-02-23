class Boardgame < ApplicationRecord
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
