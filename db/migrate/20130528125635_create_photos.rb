class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.string :image
      t.references :team

      t.timestamps
    end
  end
end
