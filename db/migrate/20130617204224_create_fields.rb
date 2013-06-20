class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.references :location
      t.string :name
      t.string :surface
      t.string :category
      t.decimal :price, :precision => 8, :scale => 2
      t.string :description

      t.timestamps
    end
  end
end
