class AddExtraDetailsToBoardgames < ActiveRecord::Migration[6.1]
  def change
    add_column :boardgames, :year_published, :integer
    add_column :boardgames, :age_rating, :integer
    add_column :boardgames, :min_playtime, :integer
    add_column :boardgames, :max_playtime, :integer
    add_column :boardgames, :min_players, :integer
    add_column :boardgames, :max_players, :integer
  end
end
