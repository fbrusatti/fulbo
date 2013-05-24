class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :captain
      t.integer :owner_id

      t.timestamps
    end
    add_index :teams, :owner_id
  end
end
