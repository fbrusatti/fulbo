class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :sport_center
      t.string :name
      t.string :address
      t.string :phone
      t.string :locality
      t.string :description

      t.timestamps
    end
  end
end
