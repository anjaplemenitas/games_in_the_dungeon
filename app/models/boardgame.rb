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
  belongs_to :user
end
