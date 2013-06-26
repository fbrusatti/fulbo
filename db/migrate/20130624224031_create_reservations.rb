class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :match
      t.references :field
      t.datetime :reservation_date
      t.timestamps
    end

    add_index :reservations, :match_id
    add_index :reservations, :field_id
  end
end
