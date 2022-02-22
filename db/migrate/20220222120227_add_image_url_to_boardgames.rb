class AddImageUrlToBoardgames < ActiveRecord::Migration[6.1]
  def change
    add_column :boardgames, :image_url, :string
  end
end
