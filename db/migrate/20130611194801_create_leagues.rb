class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.integer :organizer_id
      t.string :name
      t.string :category
      t.string :number_matches
      t.decimal :field_price, precision: 8, scale: 2
      t.decimal :registration_price, precision: 8, scale: 2
      t.string :requirements
      t.string :number_teams
      t.date :start_date
      t.timestamps
    end

    add_index :leagues, :organizer_id
  end
end
