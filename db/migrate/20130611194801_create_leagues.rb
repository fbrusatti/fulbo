class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.integer :organizer_id
      t.string :name
      t.string :category
      t.string :number_matches
      t.string :schedules
      t.string :field_price
      t.string :registration_price
      t.string :requirements
      t.string :number_teams
      t.date :start_date
      t.timestamps
    end

    add_index :leagues, :organizer_id
  end
end
