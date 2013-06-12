class CreatePointSystems < ActiveRecord::Migration
  def change
    create_table :point_systems do |t|
      t.references :league
      t.integer :win
      t.integer :tie
      t.integer :loser

      t.timestamps
    end
  end
end
