class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.references :match
      t.references :field
      t.datetime :date
      t.timestamps
    end

    add_index :turns, :match_id
    add_index :turns, :field_id
  end
end
