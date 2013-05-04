class CreateSportCenters < ActiveRecord::Migration
  def change
    create_table :sport_centers do |t|
      t.string :name
      t.string :cuit
      t.string :phone
      t.string :email
      t.string :address
      t.string :description

      t.timestamps
    end
  end
end
