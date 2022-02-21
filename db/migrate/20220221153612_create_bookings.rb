class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.boolean :buy
      t.boolean :rent
      t.references :user, null: false, foreign_key: true
      t.references :boardgame, null: false, foreign_key: true

      t.timestamps
    end
  end
end
