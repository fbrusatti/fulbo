class CreatePointSystems < ActiveRecord::Migration
  def change
    create_table :point_systems do |t|
      t.references :league
      t.integer :win, default: 3
      t.integer :tie, default: 1
      t.integer :loose, default: 0

      t.timestamps
    end
  end
end
