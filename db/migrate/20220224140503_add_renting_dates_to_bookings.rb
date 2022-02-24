class AddRentingDatesToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :rent_from, :date
    add_column :bookings, :rent_till, :date
  end
end
