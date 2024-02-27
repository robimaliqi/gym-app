class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :gym_class
      t.references :user
      t.timestamps
    end
  end
end
